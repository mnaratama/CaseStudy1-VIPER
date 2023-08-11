//
//  PaymentDetailRouter.swift
//  QRScan
//
//  Created by Naratama on 10/08/23.
//

import UIKit

protocol PaymentDetailRouterProtocol {
    static func createModule(with qrData: String) -> UIViewController
}

class PaymentDetailRouter: PaymentDetailRouterProtocol {
    
    static func createModule(with qrData: String) -> UIViewController {
        let viewController = PaymentDetailViewController(nibName: nil, bundle: nil)
        let interactor = PaymentDetailInteractor()
        let presenter = PaymentDetailPresenter(viewProtocol: viewController, interactor: interactor, qrData: qrData)
        
        interactor.presenter = presenter
        viewController.presenter = presenter
        return viewController
    }
    
}
