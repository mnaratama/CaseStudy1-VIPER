//
//  TransactionHistoryInteractor.swift
//  QRScan
//
//  Created by Naratama on 10/08/23.
//

import UIKit

protocol TransactionHistoryInteractorProtocol {
    func setupTransactionData() -> [TransactionData]
}

class TransactionHistoryInteractor: TransactionHistoryInteractorProtocol {
    
    func setupTransactionData() -> [TransactionData] {
        let transactionObject = UserDefaults.standard.object(forKey: "userTransaction")
        guard let transactionData = transactionObject as? [[String: Any]] else { return [] }
        guard transactionData.count != 0 else { return []}
        return transactionData.map({ transaction -> TransactionData in
            return TransactionData(transactionType: TransactionType(rawValue: transaction["type"] as! String) ?? .qr, transactionDate: transaction["date"] as! Date, amount: transaction["amount"] as! Int)
        })
    }
    
}
