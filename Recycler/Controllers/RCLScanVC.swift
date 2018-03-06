//
//  RCLScanVC.swift
//  Recycler
//
//  Created by Artem Rieznikov on 02.03.18.
//  Copyright © 2018 softserve.university. All rights reserved.
//

import UIKit
import AVFoundation

class RCLScanVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var output = AVCaptureMetadataOutput()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    
    var captureSession = AVCaptureSession()
    
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCamera()
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
        print(qrCode)
        validateQrCode(qrCode)
        captureSession.stopRunning()
        let alert = UIAlertController(title: nil, message: qrCode, preferredStyle: .alert)
        self.present(alert, animated: true)
        
        // duration in seconds
        let duration: Double = 2
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
            alert.dismiss(animated: true)
            self.captureSession.startRunning()
        }
    }
    
    func validateQrCode(_ qrCode: String) {
        // TODO:
        // QR code format is "trashCanID: UUID"
        // Initially the button is inactive and title is "Please scan QR"
        // If scanned qr code i invalid we the title is "It's not yours"
        // If scanned qr code is correct and trash can is empty then button becomes active and the title is "Report trash is full"
        // If scanned qr code is correct and trash can is already full then button becomes inactive and title is "Already reported"
    }
    
}
