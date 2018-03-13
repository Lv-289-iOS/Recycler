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

extension UIView {
    /// Shake animation
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.rotation")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 1.0
        animation.values = [-Double.pi / 6, Double.pi / 6, -Double.pi / 6, Double.pi / 6, -Double.pi / 7, Double.pi / 7, -Double.pi / 8, Double.pi / 8, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}

class RCLScanVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var output = AVCaptureMetadataOutput()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    var captureSession = AVCaptureSession()
    
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var explainationLabel: UILabel!
    @IBOutlet weak var trashIsFullBtn: UIButton!
    
    var scanStatus: ScanStatus = .redyToScan {
        didSet {
            trashIsFullBtn.setTitle(scanStatus.rawValue, for: .normal)
            
            switch scanStatus {
            case .redyToScan:
                setTrashIsFullBtnEnabled(false)
            case .wrong:
                setTrashIsFullBtnEnabled(false)
            case .notYours:
                setTrashIsFullBtnEnabled(false)
            case .alreadyFull:
                setTrashIsFullBtnEnabled(false)
            case .correct:
                setTrashIsFullBtnEnabled(true)
            }
        }
    }
    
    func setTrashIsFullBtnEnabled(_ isEnabled: Bool) {
        if(!trashIsFullBtn.isEnabled && isEnabled) {
            trashIsFullBtn.shake()
        }
        trashIsFullBtn.alpha = (isEnabled ? CGFloat.Design.enabledButtonAlpha : CGFloat.Design.disabledButtonAlpha)
        trashIsFullBtn.isEnabled = isEnabled
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCamera()
        setupUI()
    }
    
    func setupUI() {
        trashIsFullBtn.backgroundColor = UIColor.Button.backgroundColor
        trashIsFullBtn.setTitleColor(UIColor.Button.titleColor, for: .normal)
        trashIsFullBtn.layer.cornerRadius = CGFloat.Design.CornerRadius
        //button.layer.borderWidth = 1
        //button.layer.borderColor = UIColor.black.cgColor
        setTrashIsFullBtnEnabled(false)
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
        view.addSubview(visualEffectView)
        view.addSubview(trashIsFullBtn)
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr] // metadataOutput.availableMetadataObjectTypes
            // TODO: metadataOutput.rectOfInterest
        } else {
            print("Could not add metadata output")
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // This is the delegate's method that is called when a code is read
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
    }
    
    func getScanStatusForQR(_ qrCode: String) -> ScanStatus {
        var result: ScanStatus = .redyToScan

        if !isQrCodeBelongsToApp(qrCode) {
            result = .wrong
        } else {
            if isTrashCanYours(qrCode) {
                if isTrashCanFull(qrCode) {
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
        return qrCode.hasPrefix("trashCanID:") // QR code format is "trashCanID: UUID"
    }
    
    func isTrashCanYours(_ qrCode: String) -> Bool {
        /*
        let email = RCLAuthentificator.email()
        var userID: String?
        FirestoreService.shared.getUserBy(email: email) { user in
            if let unwrappedUser = user {
                userID = unwrappedUser.id
            }
        }
        if let unwrappedUserID = userID {
            print(unwrappedUserID)
        }
         */
        return true // TODO: implement
    }
    
    func isTrashCanFull(_ qrCode: String) -> Bool {
        var result: Bool = false
        /*
        var myTrashCan: TrashCan?
        FirestoreService.shared.getLatestTrashBy(trashCanId: "uFYf9ltIIloIxWtFiJLf") { trash in
            if let unwrappedTrash = trash {
                FirestoreService.shared.getDocumentById(from: .trashCan, returning: TrashCan.self, id: unwrappedTrash.trashCanId, completion: { trashCan in
                    trashCan?.isFull
                    myTrashCan = trashCan
                })
            }
        }
        if let myTrashCan = myTrashCan {
            result = myTrashCan.isFull
        }
         */
        return result // TODO: implement
    }
    
}

