//
//  PaymentDetailInteractorTest.swift
//  QRScanTests
//
//  Created by Naratama on 11/08/23.
//

import Foundation
import UIKit
@testable import QRScan
import XCTest

final class PaymentDetailInteractorTests: XCTestCase {
    
    func test_when_check_saldo_balance_called_when_balance_more_than_price_shouldCall_presentAfterCheckPayment() {
        // Given
        let sut = PaymentDetailInteractor()
        let spy = PaymentDetailPresenterSpy()
        sut.presenter = spy
        UserDefaults.standard.setValue(5000, forKey: "userSaldo")
        // When
        sut.checkSaldoBalance(price: 5000)
        
        // Then
        XCTAssert(spy.isSuccess!)
        XCTAssert(spy.presentAfterCheckPayment == 1)
    }
    
    func test_when_check_saldo_balance_called_when_balance_less_than_price_shouldCall_presentAfterCheckPayment() {
        // Given
        let sut = PaymentDetailInteractor()
        let spy = PaymentDetailPresenterSpy()
        sut.presenter = spy
        UserDefaults.standard.setValue(1000, forKey: "userSaldo")
        // When
        sut.checkSaldoBalance(price: 5000)
        
        // Then
        XCTAssert(!spy.isSuccess!)
        XCTAssert(spy.presentAfterCheckPayment == 1)
    }
    
    
}
