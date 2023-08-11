//
//  QRScanPresenterTest.swift
//  QRScanTests
//
//  Created by Naratama on 11/08/23.
//

import Foundation
import AVFoundation
import XCTest
@testable import QRScan
import UIKit

class QRScanViewSpy: ScanQRViewProtocol {
    
    var displayCameraCalled = 0
    func displayCamera(captureSession: AVCaptureSession, captureDevice: AVCaptureDevice?) {
        displayCameraCalled += 1
    }
    
    
}

class QRScanRouterSpy: ScanQRRouterProtocol {
    static func createModule(navigateToPaymentDetailModule: @escaping (String) -> Void) -> UIViewController {
        return UIViewController()
    }
    
    var routeToPaymentDetailCalled = 0
    func routeToPaymentDetail(qrData: String) {
        routeToPaymentDetailCalled += 1
    }
    
    
}

class QRScanInteractorSpy: ScanQRInteractorProtocol {
    
    var setupCameraCalled = 0
    func setupCamera() -> (AVCaptureSession, AVCaptureDevice?) {
        setupCameraCalled += 1
        let session = AVCaptureSession()
        let device = AVCaptureDevice(uniqueID: "ASDASD")
        return (session, device)
    }
    
    var processQRDataCalled = 0
    func processQRData(qrMetaData: String) {
        processQRDataCalled += 1
    }
    
    
}

final class QRScanPresenterTest: XCTestCase {
    
    func test_when_present_camera_called_should_call_displayCamera(){
        // Given
        let sut = ScanQRPResenter()
        let homeSpy = QRScanViewSpy()
        let routerSpy = QRScanRouterSpy()
        let interactorSpy = QRScanInteractorSpy()
        
        sut.view = homeSpy
        sut.router = routerSpy
        sut.interactor = interactorSpy
        
        // When
        sut.presentCamera()
        
        // Then
        XCTAssert(homeSpy.displayCameraCalled == 1)
    }
    
    func test_when_presentCapturedQRCalled_shouldCall_routeToPaymentDetail() {
        // Given
        let sut = ScanQRPResenter()
        let homeSpy = QRScanViewSpy()
        let routerSpy = QRScanRouterSpy()
        let interactorSpy = QRScanInteractorSpy()
        let qrData = "ANY.ANY.ANY.ANY"
        
        sut.view = homeSpy
        sut.router = routerSpy
        sut.interactor = interactorSpy
        
        // When
        sut.presentCapturedQR(qrMetaData: qrData)
        
        // Then
        XCTAssert(routerSpy.routeToPaymentDetailCalled == 1)
        
        
    }
    
    
}
