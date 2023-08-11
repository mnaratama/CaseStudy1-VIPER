//
//  QRScanViewControllerTests.swift
//  QRScanTests
//
//  Created by Naratama on 11/08/23.
//

import XCTest
import AVFoundation
@testable import QRScan

class ScanQRPresenterSpy: ScanQRPresenterProtocol {
    
    var presentCameraCalled = 0
    var presentCapturedQRCalled = 0
    
    func presentCamera() {
        presentCameraCalled += 1
    }
    
    func presentCapturedQR(qrMetaData: String) {
        presentCapturedQRCalled += 1
    }
    
   
    
    
}

final class QRScanViewControllerTests: XCTestCase {
    
    func makeSut() -> ScanQRViewController {
        let sut = ScanQRRouter.createModule(navigateToPaymentDetailModule: {_ in})
        return sut as! ScanQRViewController
    }
    
    func test_when_viewDidLoad_shouldCall_presentCamera() {
        // Given
        let sut = makeSut()
        let spy = ScanQRPresenterSpy()
        sut.presenter = spy
        
        // When
        loadView(withSut: sut)
        
        // Then
        XCTAssert(spy.presentCameraCalled == 1)
    }
    
    func loadView(withSut: UIViewController) {
        let window = UIWindow()
        window.addSubview(withSut.view)
        RunLoop.current.run(until: Date())
    }
}
