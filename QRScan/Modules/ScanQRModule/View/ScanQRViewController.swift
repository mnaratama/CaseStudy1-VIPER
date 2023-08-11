//
//  ScanQRViewController.swift
//  QRScan
//
//  Created by Naratama on 11/08/23.
//

import UIKit
import AVFoundation
import TTGSnackbar

protocol ScanQRViewProtocol  {
    func displayCamera(captureSession: AVCaptureSession, captureDevice: AVCaptureDevice?)
}

class ScanQRViewController: UIViewController, ScanQRViewProtocol, AVCaptureMetadataOutputObjectsDelegate {
    
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    var presenter: ScanQRPresenterProtocol?
    
    var captureSession: AVCaptureSession?
    
    func displayCamera(captureSession: AVCaptureSession, captureDevice: AVCaptureDevice?) {
        do {
            guard let captureDevice else {
                return
            }
            self.captureSession = captureSession
            let input = try AVCaptureDeviceInput(device: captureDevice)
            self.captureSession?.addInput(input)
            
            let output = AVCaptureMetadataOutput()
            self.captureSession?.addOutput(output)
            
            output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            output.metadataObjectTypes = [.qr]
            
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(previewLayer!)
            DispatchQueue.global(qos: .background).async {
                self.captureSession?.startRunning()
            }
        } catch {
            let alert = UIAlertController(title: "Izin Kamera Diperlukan", message: "Mohon memberikan izin aplikasi ini untuk menggunakan kamera", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }
            alert.addAction(okAction)
            present(alert, animated: true)
        }
    }
    
    
    override func viewDidLoad() {
        presenter?.presentCamera()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        captureSession?.stopRunning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.global(qos: .background).async {
            self.captureSession?.startRunning()
        }
       
    }
}

extension ScanQRViewController {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let captureSession else { return }
        if captureSession.isRunning {
            captureSession.stopRunning()
            if let metaData = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
               let qrCodeString = metaData.stringValue {
                guard qrCodeString.components(separatedBy: ".").count == 4 else { return }
                presenter?.presentCapturedQR(qrMetaData: qrCodeString)
            } else {
                captureSession.startRunning()
                let snackBar = TTGSnackbar(message: "QR tidak sah", duration: .middle)
                snackBar.animationType = .slideFromTopBackToTop
                snackBar.backgroundColor = .red
                snackBar.show()
            }
        } else {
            captureSession.startRunning()
        }
    }
}
