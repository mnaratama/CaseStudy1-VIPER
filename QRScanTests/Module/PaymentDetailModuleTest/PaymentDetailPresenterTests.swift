//
//  PaymentDetailPresenterTests.swift
//  QRScanTests
//
//  Created by Naratama on 11/08/23.
//

import Foundation
import UIKit
@testable import QRScan
import XCTest

class PaymentDetailViewSpy: PaymentDetailViewProtocol {
    
    var displayPaymentDetailCalled = 0
    func displayPaymentDetail(viewModel: QRScan.PaymentDetailEntity) {
        displayPaymentDetailCalled += 1
    }
    
    var displayPaymentSuccessCalled = 0
    func displayPaymentSuccess() {
        displayPaymentSuccessCalled += 1
    }
    
    var displayPaymentFailedCalled = 0
    func displayPaymentFailed(info: String) {
        displayPaymentFailedCalled += 1
    }
    
    
}

class PaymentDetailIntercatorSpy: PaymentDetailInteractorProtocol {
    
    var checkSaldoBalanceCalled = 0
    func checkSaldoBalance(price: Int) {
        checkSaldoBalanceCalled += 1
    }
    
    
}

final class PaymentDetailPresenterTests: XCTestCase {
    
    func makeSut() -> PaymentDetailPresenter {
        let homeSpy = PaymentDetailViewSpy()
        let qrData = "BNI.ID12345678.MERCHANT MOCK TEST.50000"
        let interactorSpy = PaymentDetailIntercatorSpy()
        let sut = PaymentDetailPresenter(viewProtocol: homeSpy, interactor: interactorSpy, qrData: qrData)
        return sut
    }
    
    func test_when_present_payment_detail_shouldCall_ddisplayPaymentDetail() {
        // Given
        let sut = makeSut()
        let homeSpy = PaymentDetailViewSpy()
        sut.viewProtocol = homeSpy
        
        // When
        sut.presentPaymentDetail()
        
        // Then
        XCTAssert(homeSpy.displayPaymentDetailCalled == 1)
    }
    
    func test_when_checkPaymentCalled_should_call_checkSaldoBalance() {
        // Given
        let sut = makeSut()
        let interactorSpy = PaymentDetailIntercatorSpy()
        sut.interactor = interactorSpy
        
        // When
        sut.checkPayment()
        
        // Then
        XCTAssert(interactorSpy.checkSaldoBalanceCalled == 1)
    }
    
    func test_when_present_after_check_payment_called_andSuccess_shouldCall_displayPaymentSuccess() {
        // Given
        let sut = makeSut()
        let homeSpy = PaymentDetailViewSpy()
        let isSuccess = true
        sut.viewProtocol = homeSpy
        
        // When
        sut.presentAfterCheckPayment(isSuccess: isSuccess, info: nil)
        
        // Then
        XCTAssert(homeSpy.displayPaymentSuccessCalled == 1)
        XCTAssert(homeSpy.displayPaymentFailedCalled == 0)
    }
    
    func test_when_present_after_check_payment_called_andSuccess_shouldCall_displayPaymentFailed() {
        // Given
        let sut = makeSut()
        let homeSpy = PaymentDetailViewSpy()
        let isSuccess = false
        sut.viewProtocol = homeSpy
        
        // When
        sut.presentAfterCheckPayment(isSuccess: isSuccess, info: "Payment Failed")
        
        // Then
        XCTAssert(homeSpy.displayPaymentSuccessCalled == 0)
        XCTAssert(homeSpy.displayPaymentFailedCalled == 1)
    }
}
