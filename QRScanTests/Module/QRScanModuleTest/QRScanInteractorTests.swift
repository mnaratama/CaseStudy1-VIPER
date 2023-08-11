//
//  QRScanInteractorTests.swift
//  QRScanTests
//
//  Created by Naratama on 11/08/23.
//

import Foundation
import XCTest
@testable import QRScan

final class QRScanInteractorTests: XCTestCase {
    
    func test_whenSetupCameraCalled_shouldNotReturn_nil() {
        // Given
        let sut = ScanQRInteractor()
        let camera = sut.setupCamera()
        
        // Then
        XCTAssertNotNil(camera)
        
    }
    
    
}
