//
//  HomeRouter.swift
//  QRScan
//
//  Created by Naratama on 10/08/23.
//

import UIKit

protocol HomeRouterProtcol {
    static func createModule(routeToScanQR: @escaping () -> Void, routeToTransactionHistory: @escaping () -> Void) -> UIViewController
    func routeToScanQR()
    func routeToTransactionHistory()
}

class HomeRouter: HomeRouterProtcol {
    
    var navigateToScanQRViewController: () -> Void = {}
    var navigateToHistoryTransactionViewController: () -> Void = {}
    
    static func createModule(routeToScanQR: @escaping () -> Void, routeToTransactionHistory: @escaping () -> Void) -> UIViewController {
        let router = HomeRouter()
        let presenter = HomePresenter(router: router)
        let viewController = HomeViewController()
        router.navigateToScanQRViewController = routeToScanQR
        router.navigateToHistoryTransactionViewController = routeToTransactionHistory
        viewController.homePresenter = presenter
        presenter.view = viewController
        return viewController
    }
    
    func routeToTransactionHistory() {
        navigateToHistoryTransactionViewController()
    }
    
    func routeToScanQR() {
        navigateToScanQRViewController()
    }
}
