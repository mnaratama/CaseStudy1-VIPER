//
//  HomeViewControllerTest.swift
//  QRScanTests
//
//  Created by Naratama on 11/08/23.
//

import XCTest
@testable import QRScan

class HomePresenterSpy: HomePresenterProtocol {
    
    var presentTableViewCalled = 0
    var presentToScanQRCalled = 0
    var presentToHistoryTransactionCalled = 0
    
    func presentTableView() {
        presentTableViewCalled += 1
    }
    
    func presentToScanQR() {
        presentToScanQRCalled += 1
    }
    
    func presentToHistoryTransaction() {
        presentToHistoryTransactionCalled += 0
    }
}


final class HomeTest: XCTestCase {


    func makeSut() -> HomeViewController {
        let sut = HomeRouter.createModule(routeToScanQR: {
        }, routeToTransactionHistory: {
        })
        return sut as! HomeViewController
    }
    
    func test_when_viewDidLoad_shouldCall_presentTableView() {
        // Given
        let sut = makeSut()
        let spy = HomePresenterSpy()
        sut.homePresenter = spy
        
        // When
        loadView(withSut: sut)
        
        // Then
        XCTAssert(spy.presentTableViewCalled == 1)
    }
    
    
    func test_when_viewDidLoad_presenterShouldNotNil() {
        // Given
        let sut = makeSut()
        
        // When
        loadView(withSut: sut)
        
        // Then
        XCTAssert(sut.homePresenter != nil)
    }
    
    func test_when_viewDidLoad_dataSourceShouldNotNil() {
        // Given
        let sut = makeSut()
        
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
