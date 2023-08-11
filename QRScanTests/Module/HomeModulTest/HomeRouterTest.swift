//
//  HomeRouterTest.swift
//  QRScanTests
//
//  Created by Naratama on 11/08/23.
//

import Foundation
import UIKit
import XCTest
@testable import QRScan


final class HomeRouterTest: XCTestCase {
    func test_when_routeToQRCalled_shouldCall_navigateToQR() {
        // Given
        let sut = HomeRouter()
        
        var navigateToQR = 0
        sut.navigateToScanQRViewController = {
            navigateToQR += 1
        }
        
        // When
        sut.routeToScanQR()
        
        // Then
        XCTAssert(navigateToQR == 1)
    }
    
    func test_when_routeToTransactionHistoryCalled_shouldCall_navigateToTransactionHistory() {
        // Given
        let sut = HomeRouter()
        
        var navigateToTransactionHistoryCalled = 0
        sut.navigateToHistoryTransactionViewController = {
            navigateToTransactionHistoryCalled += 1
        }
        
        // When
        sut.routeToTransactionHistory()
        
        // Then
        XCTAssert(navigateToTransactionHistoryCalled == 1)
    }
}
