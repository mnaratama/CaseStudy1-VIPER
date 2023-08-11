//
//  ScanQRPresenter.swift
//  QRScan
//
//  Created by Naratama on 11/08/23.
//

import Foundation
import AVFoundation

protocol ScanQRPresenterProtocol {
    func presentCamera()
    func presentCapturedQR(qrMetaData: String)
    
}

class ScanQRPResenter: ScanQRPresenterProtocol {
    
    var interactor: ScanQRInteractorProtocol?
    var router: ScanQRRouterProtocol?
    var view: ScanQRViewProtocol?

    func presentCamera() {
        let captureSession = interactor?.setupCamera()
        view?.displayCamera(captureSession: captureSession!.0, captureDevice: captureSession?.1)
    }
    
    func presentCapturedQR(qrMetaData: String) {
        router?.routeToPaymentDetail(qrData: qrMetaData)
    }
}
