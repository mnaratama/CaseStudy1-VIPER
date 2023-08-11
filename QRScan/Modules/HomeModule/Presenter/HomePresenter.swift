//
//  HomePresenter.swift
//  QRScan
//
//  Created by Naratama on 11/08/23.
//

import UIKit

protocol HomePresenterProtocol {
    func presentTableView()
    func presentToScanQR()
    func presentToHistoryTransaction()
}

class HomePresenter: HomePresenterProtocol {
    
    var view: HomeViewProtocol?
    let router: HomeRouterProtcol
    
    init(router: HomeRouterProtcol) {
        self.router = router
    }
    
    convenience init(view: HomeViewProtocol?, router: HomeRouterProtcol) {
        self.init(router: router)
        self.view = view
    }
    
    func presentTableView() {
        view?.setFirstTableView()
    }
    
    func presentToScanQR() {
        router.routeToScanQR()
    }
    
    func presentToHistoryTransaction() {
        router.routeToTransactionHistory()
    }
 
}
