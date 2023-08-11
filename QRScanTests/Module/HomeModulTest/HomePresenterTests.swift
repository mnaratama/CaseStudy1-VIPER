//
//  HomePresenterTests.swift
//  QRScanTests
//
//  Created by Naratama on 11/08/23.
//

import Foundation
import UIKit
import XCTest
@testable import QRScan

class HomeViewControllerSpy: HomeViewProtocol {
    var setFirstViewTableCalled = 0
    
    func setFirstTableView() {
        setFirstViewTableCalled += 1
    }
}

class HomeRouterSpy: HomeRouterProtcol {
    static func createModule(routeToScanQR: @escaping () -> Void, routeToTransactionHistory: @escaping () -> Void) -> UIViewController {
        return UIViewController()
    }
    
    var routeToScanQRCalled = 0
    var routeToTransactionHistoryCalled = 0
    
    func routeToScanQR() {
        routeToScanQRCalled += 1
    }
    
    func routeToTransactionHistory() {
        routeToTransactionHistoryCalled += 1
    }
    
    
}

final class HomePresenterTest: XCTestCase {
    
    func test_when_presentQRCalled_shouldCall_routeToQR() {
        // Given
        let routerSpy = HomeRouterSpy()
        let homeSpy = HomeViewControllerSpy()
        let sut = HomePresenter(view: homeSpy, router: routerSpy)
       
        // When
        sut.presentToScanQR()
        
        // Then
        XCTAssert(routerSpy.routeToScanQRCalled == 1)
    }
    
    func test_when_presentHistory_called_shouldCall_routeToHistory() {
        // Given
        let routerSpy = HomeRouterSpy()
        let homeSpy = HomeViewControllerSpy()
        let sut = HomePresenter(view: homeSpy, router: routerSpy)
       
        // When
        sut.presentToHistoryTransaction()
        
        // Then
        XCTAssert(routerSpy.routeToTransactionHistoryCalled == 1)
    }
    
    func test_when_present_tableViewCalled_shouldCall_setFirstTableView() {
        // Given
        let routerSpy = HomeRouterSpy()
        let homeSpy = HomeViewControllerSpy()
        let sut = HomePresenter(view: homeSpy, router: routerSpy)
       
        // When
        sut.presentTableView()
        
        // Then
        XCTAssert(homeSpy.setFirstViewTableCalled == 1)
    }
    
}
