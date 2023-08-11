//
//  ScanQRInteractor.swift
//  QRScan
//
//  Created by Naratama on 11/08/23.
//

import Foundation
import AVFoundation

protocol ScanQRInteractorProtocol {
    func setupCamera() -> (AVCaptureSession, AVCaptureDevice?)
}

class ScanQRInteractor: ScanQRInteractorProtocol {
    
    func setupCamera() -> (AVCaptureSession, AVCaptureDevice?) {
        let captureSession = AVCaptureSession()
        guard let captureDevice = AVCaptureDevice.default(for: .video) else {
            print("Failed to get the camera device.")
            return (AVCaptureSession(), AVCaptureDevice(uniqueID: ""))
        }
        return (captureSession, captureDevice)
    }
}
