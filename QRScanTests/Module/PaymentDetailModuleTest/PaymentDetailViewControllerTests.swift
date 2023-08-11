//
//  PaymentDetailViewControllerTests.swift
//  QRScanTests
//
//  Created by Naratama on 11/08/23.
//

import Foundation
import UIKit
@testable import QRScan
import XCTest

class PaymentDetailPresenterSpy: PaymentDetailPresenterProtocol{
    
    var presentAfterCheckPayment = 0
    var isSuccess: Bool?
    var info: String?
    func presentAfterCheckPayment(isSuccess: Bool, info: String?) {
        self.isSuccess = isSuccess
        self.info = info
        self.presentAfterCheckPayment += 1
    }
    
    
    var presentPaymentDetailCalled = 0
    func presentPaymentDetail() {
        presentPaymentDetailCalled += 1
    }
    
    var checkPaymentCalled = 0
    func checkPayment() {
        checkPaymentCalled += 1
    }
}

final class PaymentDetailViewControllerTests: XCTestCase {
    func makeSut() -> PaymentDetailViewController {
        let sut = PaymentDetailRouter.createModule(with: "QRDATA.DATA")
        return sut as! PaymentDetailViewController
    }
    
    func when_view_didLoad_shouldCall_presentPaymentDetail() {
        // Given
        let sut = makeSut()
        let spy = PaymentDetailPresenterSpy()
        sut.presenter = spy
        
        // When
        loadView(withSut: sut)
        
        // Then
        XCTAssert(spy.presentPaymentDetailCalled == 1)
    }
    
    func when_payButtonTapped_shouldCall_checkPayment() {
        // Given
        let sut = makeSut()
        let spy = PaymentDetailPresenterSpy()
        sut.presenter = spy
        
        // When
        loadView(withSut: sut)
        sut.payButtonTapped()
        
        // Then
        XCTAssert(spy.checkPaymentCalled == 1)
    }
    
    func loadView(withSut: UIViewController) {
        let window = UIWindow()
        window.addSubview(withSut.view)
        RunLoop.current.run(until: Date())
    }

}
