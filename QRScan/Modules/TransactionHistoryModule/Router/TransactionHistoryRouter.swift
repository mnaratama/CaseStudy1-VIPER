//
//  TransactionHistoryRouter.swift
//  QRScan
//
//  Created by Naratama on 10/08/23.
//

import UIKit

protocol TransactionHistoryRouterProtocol {
    static func createModule() -> UIViewController
}

class TransactionHistoryRouter: TransactionHistoryRouterProtocol {
    
    static func createModule() -> UIViewController {
        let viewController = TransactionHistoryViewController(nibName: nil, bundle: nil)
        let interactor = TransactionHistoryInteractor()
        let presenter = TransactionHistoryPresenter(viewProtocol: viewController, interactor: interactor)
        
        viewController.presenter = presenter
        
        return viewController
    }
    
    
}
