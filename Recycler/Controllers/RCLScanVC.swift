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
    case notYours = "It's not yours" // there is QR code but this trash can does not belong to current user
    case alreadyReported = "Already reported" // there is QR code, this trash can belongs to current user but it is already full
    case correct = "Correct QR" // there is QR code and it's format is OK for our app
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
            //explainationLabel.text = scanStatus.rawValue
            trashIsFullBtn.setTitle(scanStatus.rawValue, for: .normal)
            
            switch scanStatus {
            case .redyToScan:
                setTrashIsFullBtnEnabled(false)
            case .wrong:
                setTrashIsFullBtnEnabled(false)
            case .notYours:
                setTrashIsFullBtnEnabled(false)
            case .alreadyReported:
                setTrashIsFullBtnEnabled(false)
            case .correct:
                setTrashIsFullBtnEnabled(true)
            }
        }
    }
    
    func setTrashIsFullBtnEnabled(_ isEnabled: Bool) {
        trashIsFullBtn.isEnabled = isEnabled
        trashIsFullBtn.alpha =  (isEnabled ? CGFloat(1) : CGFloat(0.5))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCamera()
        setupUI()
    }
    
    func setupUI() {
        trashIsFullBtn.alpha = 0.5
        trashIsFullBtn.backgroundColor = UIColor.Button.backgroundColor
        trashIsFullBtn.setTitleColor(UIColor.Button.titleColor, for: .normal)
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
                onQrCodeRead(code)
            }
        }
    }
    
    func onQrCodeRead(_ qrCode: String) {
        var newScanStatus: ScanStatus = .redyToScan
        
        if explainationLabel.text != qrCode {
            explainationLabel.text = qrCode
        }
        
        if !isQrCodeBelongsToApp(qrCode) {
            newScanStatus = .wrong
        } else {
            if isTrashCanYours(qrCode) {
                if isTrashCanEmpty(qrCode) {
                    newScanStatus = .correct
                } else {
                    newScanStatus = .alreadyReported
                }
            }
            else {
                newScanStatus = .notYours
            }
        }
        
        if scanStatus != newScanStatus {
           scanStatus = newScanStatus
        }
    }
    
    func isQrCodeBelongsToApp(_ qrCode: String) -> Bool {
        return qrCode.hasPrefix("trashCanID:") // QR code format is "trashCanID: UUID"
    }
    
    func isTrashCanYours(_ qrCode: String) -> Bool {
        return true // TODO: implement
    }
    
    func isTrashCanEmpty(_ qrCode: String) -> Bool {
        return true // TODO: implement
    }
    
}

