//
//  RCLScanVC.swift
//  Recycler
//
//  Created by Artem Rieznikov on 02.03.18.
//  Copyright © 2018 softserve.university. All rights reserved.
//

import UIKit
import AVFoundation

enum ScanStatus: String {
    case redyToScan = "Please scan QR" // there is no QR code in camera view, ready to scan
    case wrong = "Wrong QR" // there is QR code but it's format is different from our app format "trashCanID: UUID"
    case notYours = "Trash can is not yours" // there is QR code but this trash can does not belong to current user
    case alreadyFull = "Trash can is already full" // there is QR code, this trash can belongs to current user but it is already full
    case correct = "Trash can is full" // there is QR code and it's format is OK for our app
}

struct QrConstants {
    static let codePrefix = "trashCanID:" // QR code format is "trashCanID:UUID"
}

extension UIView {
    /// Shake animation
    func animationShakeStart() {
        let animation = CAKeyframeAnimation(keyPath: "transform.rotation")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 1.0
        animation.values = [-Double.pi / 6, Double.pi / 6, -Double.pi / 6, Double.pi / 6, -Double.pi / 7, Double.pi / 7, -Double.pi / 8, Double.pi / 8, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    
    func animationsStop() {
        layer.removeAllAnimations()
        layoutIfNeeded()
    }
}

class RCLScanVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var output = AVCaptureMetadataOutput()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    var captureSession = AVCaptureSession()
    
    var userTrashCans = [TrashCan]()
    var trashCanToReport: TrashCan? = nil
    
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var explainationLabel: UILabel!
    @IBOutlet weak var trashIsFullBtn: UIButton!
    
    var scanStatus: ScanStatus = .redyToScan {
        didSet {
            trashIsFullBtn.setTitle(scanStatus.rawValue, for: .normal)
            
            switch scanStatus {
            case .redyToScan:
                setTrashIsFullBtnEnabled(false)
                visualEffectView.isHidden = false
                explainationLabel.text = scanStatus.rawValue
            case .wrong:
                setTrashIsFullBtnEnabled(false)
                visualEffectView.isHidden = false
            case .notYours:
                setTrashIsFullBtnEnabled(false)
                visualEffectView.isHidden = true
            case .alreadyFull:
                setTrashIsFullBtnEnabled(false)
                visualEffectView.isHidden = false
            case .correct:
                setTrashIsFullBtnEnabled(true)
                visualEffectView.isHidden = false
            }
        }
    }
    
    func setTrashIsFullBtnEnabled(_ isEnabled: Bool) {
        if(!trashIsFullBtn.isEnabled && isEnabled) {
            trashIsFullBtn.animationShakeStart()
        } else {
            trashIsFullBtn.animationsStop()
        }
        trashIsFullBtn.alpha = (isEnabled ? CGFloat.Design.enabledButtonAlpha : CGFloat.Design.disabledButtonAlpha)
        trashIsFullBtn.isEnabled = isEnabled
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCamera()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getTrashCans(forUser: currentUser)
    }
    
    func setupUI() {
        trashIsFullBtn.backgroundColor = UIColor.Button.backgroundColor
        trashIsFullBtn.setTitleColor(UIColor.Button.titleColor, for: .normal)
        trashIsFullBtn.layer.cornerRadius = CGFloat.Design.CornerRadius
        addTitleLabel(text: "Scan to report")
        setTrashIsFullBtnEnabled(false)
        scanStatus = .redyToScan
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !captureSession.isRunning {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if captureSession.isRunning {
            captureSession.stopRunning()
        }
    }
    
    private func setupCamera() {
        guard let device = AVCaptureDevice.default(for: .video),
            let input = try? AVCaptureDeviceInput(device: device) else {
                return
        }
        
        if captureSession.canAddInput(input) {
            captureSession.addInput(input)
        }
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.videoGravity = .resizeAspectFill
        videoPreviewLayer.frame = view.bounds
        view.layer.addSublayer(videoPreviewLayer)
        //view.bringSubview(toFront: <#T##UIView#>)
        view.addSubview(visualEffectView)
        view.addSubview(trashIsFullBtn)
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            print("Could not add metadata output")
        }
    }
    
    // Informs the delegate when a code is read
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        for metadata in metadataObjects {
            if let readableObject = metadata as? AVMetadataMachineReadableCodeObject,
                let code = readableObject.stringValue {
                dismiss(animated: true)
                updateGUIForQR(code)
            }
        }
    }
    
    func updateGUIForQR(_ qrCode: String) {
        if explainationLabel.text != qrCode {
            explainationLabel.text = qrCode
        }
        
        let newScanStatus = getScanStatusForQR(qrCode)
        if scanStatus != newScanStatus {
           scanStatus = newScanStatus
        }
        
        if let trashCan = trashCanToReport {
            explainationLabel.text = trashCan.type
        }
    }
    
    func getScanStatusForQR(_ qrCode: String) -> ScanStatus {
        var result: ScanStatus = .redyToScan
        trashCanToReport = nil
        
        if !isQrCodeBelongsToApp(qrCode) {
            result = .wrong
        } else {
            if let trashCan = getUserTrashCanBy(id: qrCode) {
                trashCanToReport = trashCan
                
                if trashCan.isFull {
                    result = .alreadyFull
                } else {
                    result = .correct
                }
            }
            else {
                result = .notYours
            }
        }
        return result
    }
    
    func isQrCodeBelongsToApp(_ qrCode: String) -> Bool {
        return qrCode.hasPrefix(QrConstants.codePrefix)
    }
    
    func getUserTrashCanBy(id: String) -> TrashCan? {
        userTrashCans.filter { (trashCan) -> Bool in
             return true//(trashCan.id, id.range(of: trashCan.id!) != nil)
        }
        return nil
    }
    
    private func getTrashCans(forUser: User) {
        guard let userId = forUser.id else {
            return
        }
        FirestoreService.shared.getTrashCansBy(userId: userId) { result in
            self.userTrashCans = result
        }
    }
    
    @IBAction func btnTrashCanIsFullClicked(_ sender: UIButton) {
        if var trashCan = trashCanToReport {
            if let trashCanId = trashCan.id {
                if let currentUserId = currentUser.id {
                    trashCan.isFull = true
                    FirestoreService.shared.update(for: trashCan, in: .trashCan)
                    
                    var trash = Trash(trashCanId: trashCanId, userIdReportedFull: currentUserId)
                    trash.dateReportedFull = Date()
                    FirestoreService.shared.add(for: trash, in: .trash)
                }
            }
        }
    }
    
}
