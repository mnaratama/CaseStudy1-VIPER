//
//  PaymentDetailPresenter.swift
//  QRScan
//
//  Created by Naratama on 10/08/23.
//

import Foundation

protocol PaymentDetailPresenterProtocol {
    func presentPaymentDetail()
    func checkPayment()
    func presentAfterCheckPayment(isSuccess: Bool, info: String?)
}

class PaymentDetailPresenter: PaymentDetailPresenterProtocol {
    
    var viewProtocol: PaymentDetailViewProtocol
    var interactor: PaymentDetailInteractorProtocol
    let qrData: String
    
    init(viewProtocol: PaymentDetailViewProtocol, interactor: PaymentDetailInteractorProtocol, qrData: String) {
        self.qrData = qrData
        self.interactor = interactor
        self.viewProtocol = viewProtocol
    }
    
    func presentPaymentDetail() {
        let stringData = qrData.components(separatedBy: ".")
        let paymenDetailEntity = PaymentDetailEntity(bankOrigin: stringData[0], transactionCode: stringData[1], merchantName: stringData[2], price: stringData[3])
        
        viewProtocol.displayPaymentDetail(viewModel: paymenDetailEntity)
    }
    
    func checkPayment() {
        let priceString = qrData.components(separatedBy: ".")[3]
        let priceInt = Int(priceString)
        interactor.checkSaldoBalance(price: priceInt ?? 0)
    }
    
    func presentAfterCheckPayment(isSuccess: Bool, info: String?) {
        if isSuccess {
            viewProtocol.displayPaymentSuccess()
        } else {
            viewProtocol.displayPaymentFailed(info: info!)
        }
    }
}
