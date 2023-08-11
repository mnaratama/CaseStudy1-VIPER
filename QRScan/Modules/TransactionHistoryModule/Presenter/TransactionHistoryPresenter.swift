//
//  TransactionHistoryPresenter.swift
//  QRScan
//
//  Created by Naratama on 10/08/23.
//

import Foundation

protocol TransactionHistoryPresenterProtocol {
    func presentTableView()
}

class TransactionHistoryPresenter: TransactionHistoryPresenterProtocol {
    
    var viewProtocol: TransactionHistoryViewProtocol
    var interactor: TransactionHistoryInteractorProtocol
    
    init(viewProtocol: TransactionHistoryViewProtocol, interactor: TransactionHistoryInteractorProtocol) {
        self.viewProtocol = viewProtocol
        self.interactor = interactor
    }
    
    func presentTableView() {
        let transactionData = interactor.setupTransactionData()
        if transactionData.count == 0 {
            viewProtocol.displayNoTransaction()
        } else {
            viewProtocol.setTableView(with: transactionData)
        }
        
    }
    
    
}
