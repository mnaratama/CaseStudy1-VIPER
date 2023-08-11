//
//  ScanQRRouter.swift
//  QRScan
//
//  Created by Naratama on 11/08/23.
//

import UIKit

protocol ScanQRRouterProtocol {
    static func createModule(navigateToPaymentDetailModule: @escaping (String) -> Void) -> UIViewController
    func routeToPaymentDetail(qrData: String)
}

class ScanQRRouter: ScanQRRouterProtocol {
    
    var navigateToPaymentDetail: (String) -> Void = {_ in}
    
    static func createModule(navigateToPaymentDetailModule: @escaping (String) -> Void) -> UIViewController {
        let presenter = ScanQRPResenter()
        let interactor = ScanQRInteractor()
        let router = ScanQRRouter()
        router.navigateToPaymentDetail = navigateToPaymentDetailModule
        presenter.interactor = interactor
        let viewController = ScanQRViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.router = router
        return viewController
    }
    
    func routeToPaymentDetail(qrData: String) {
        navigateToPaymentDetail(qrData)
    }
}
