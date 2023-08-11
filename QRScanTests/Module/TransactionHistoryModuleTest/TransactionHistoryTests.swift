//
//  QRScanTests.swift
//  QRScanTests
//
//  Created by Naratama on 10/08/23.
//

import XCTest
import UIKit
@testable import QRScan

class TransactionHistoryPresenterSpy: TransactionHistoryPresenterProtocol {
    
    var presentTableViewCalled = 0
    func presentTableView() {
        presentTableViewCalled += 1
    }
    
    
}

class TransactionHistoryViewControllerTest: XCTestCase {
    func makeSut() -> TransactionHistoryViewController {
        let sut = TransactionHistoryRouter.createModule()
        return sut as! TransactionHistoryViewController
    }
    
    func test_when_viewDidLoad_shouldCall_presentTableView(){
        // Given
        let sut = makeSut()
        let spy = TransactionHistoryPresenterSpy()
        sut.presenter = spy
        
        // When
        loadView(withSut: sut)
        
        // Then
        XCTAssert(spy.presentTableViewCalled == 1)
    }
    
    func test_when_viewDidLoad_dataSourceShouldNotNil(){
        // Given
        let sut = makeSut()
        let spy = TransactionHistoryPresenterSpy()
        sut.presenter = spy
        
        // When
        loadView(withSut: sut)
        
        // Then
        XCTAssert(sut.dataSource != nil)
    }
    
    func loadView(withSut: UIViewController) {
        let window = UIWindow()
        window.addSubview(withSut.view)
        RunLoop.current.run(until: Date())
    }
}
