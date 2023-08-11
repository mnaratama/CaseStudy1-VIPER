//
//  TransactionHistoryPresenterTests.swift
//  QRScanTests
//
//  Created by Naratama on 11/08/23.
//

import Foundation
import UIKit
@testable import QRScan
import XCTest

class TransactionHistoryViewSpy: TransactionHistoryViewProtocol {
    
    var setTableViewCalled = 0
    func setTableView(with transactionData: [QRScan.TransactionData]) {
        setTableViewCalled += 1
    }
    
    var displayNoTransactionCalled = 0
    func displayNoTransaction() {
        displayNoTransactionCalled += 1
    }
    
    
}

class TransactionHistoryInteractorSpy: TransactionHistoryInteractorProtocol {
    
    var setupTransactionDataCalled = 0
    func setupTransactionData() -> [QRScan.TransactionData] {
        setupTransactionDataCalled += 1
        return [TransactionData(transactionType: .qr, transactionDate: Date(), amount: 10000)]
    }
}

class TransactionHistoryInteractorZeroTransactionSpy: TransactionHistoryInteractorProtocol {
    
    var setupTransactionDataCalled = 0
    func setupTransactionData() -> [QRScan.TransactionData] {
        setupTransactionDataCalled += 1
        return []
    }
}

final class TransactionHistoryPresenterTest: XCTestCase {
    
    func makeSut() -> TransactionHistoryPresenter {
        let viewSpy = TransactionHistoryViewSpy()
        let interactorSpy = TransactionHistoryInteractorSpy()
        let presenter = TransactionHistoryPresenter(viewProtocol: viewSpy, interactor: interactorSpy)
        return presenter
    }
    
    func test_when_presenTableViewCalled_and_transactionDataCount_more_than_zero() {
        // Given
        let sut = makeSut()
        let interactorSpy = TransactionHistoryInteractorSpy()
        let viewSpy = TransactionHistoryViewSpy()
        sut.viewProtocol = viewSpy
        sut.interactor = interactorSpy
        
        // When
        sut.presentTableView()
        
        // Then
        XCTAssert(viewSpy.displayNoTransactionCalled == 0)
        XCTAssert(viewSpy.setTableViewCalled == 1)
    }
    
    func test_when_presenTableViewCalled_and_transactionDataCount_is_zero() {
        // Given
        let sut = makeSut()
        let interactorSpy = TransactionHistoryInteractorZeroTransactionSpy()
        let viewSpy = TransactionHistoryViewSpy()
        sut.viewProtocol = viewSpy
        sut.interactor = interactorSpy
        
        // When
        sut.presentTableView()
        
        // Then
        XCTAssert(viewSpy.displayNoTransactionCalled == 1)
        XCTAssert(viewSpy.setTableViewCalled == 0)
    }
    
}
