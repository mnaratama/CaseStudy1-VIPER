//
//  QRScanRouteTests.swift
//  QRScanTests
//
//  Created by Naratama on 11/08/23.
//

import Foundation
@testable import QRScan
import XCTest

final class QRScanRouterTest: XCTestCase {
    
    func test_when_routeToPaymentDetailCalled_shouldCall_navigateToPaymentDetail() {
        // Given
        let sut = ScanQRRouter()
        var navigateToPaymentDetail = 0
        
        sut.navigateToPaymentDetail = { _ in
            navigateToPaymentDetail += 1
        }
        
        // When
        sut.routeToPaymentDetail(qrData: "qr")
        
        // Then
        XCTAssert(navigateToPaymentDetail == 1)
    }
    
    func test_when_routeToPaymentDetailCalled_sqr_shouldNotEmpty() {
        // Given
        let sut = ScanQRRouter()
        var qrData = ""
        
        sut.navigateToPaymentDetail = { qr in
            qrData = qr
        }
        
        // When
        sut.routeToPaymentDetail(qrData: "QR.QR.QR.QR")
        
        // Then
        XCTAssert(qrData != "")
    }

    
}
