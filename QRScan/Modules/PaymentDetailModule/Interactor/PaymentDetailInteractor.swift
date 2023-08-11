//
//  PaymentDetailInteractor.swift
//  QRScan
//
//  Created by Naratama on 10/08/23.
//

import Foundation

protocol PaymentDetailInteractorProtocol {
    func checkSaldoBalance(price: Int)
}

class PaymentDetailInteractor: PaymentDetailInteractorProtocol {
    
    var presenter: PaymentDetailPresenterProtocol?
    
    func checkSaldoBalance(price: Int) {
        let balance = UserDefaults.standard.integer(forKey: "userSaldo")
        if balance >= price {
            UserDefaults.standard.set(balance-price, forKey: "userSaldo")
            updateTransactionData(price: price)
            presenter?.presentAfterCheckPayment(isSuccess: true, info: nil)
        } else if balance < price {
            presenter?.presentAfterCheckPayment(isSuccess: false, info: "Maaf saldo anda tidak cukup")
        } else {
            presenter?.presentAfterCheckPayment(isSuccess: false, info: "Error saat melakukan pembayaran")
        }
    }
    
    private func updateTransactionData(price: Int) {
        let transactionObject = UserDefaults.standard.object(forKey: "userTransaction")
        guard var transactionData = transactionObject as? [[String: Any]] else { return }
        transactionData.append([
            "type": "qr",
            "date": Date(),
            "amount": price
        ])
        UserDefaults.standard.set(transactionData, forKey: "userTransaction")
    }

}
