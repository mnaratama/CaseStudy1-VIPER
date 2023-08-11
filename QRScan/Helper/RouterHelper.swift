//
//  RouterHelper.swift
//  QRScan
//
//  Created by Naratama on 10/08/23.
//

import UIKit

public protocol RouterHelperProtcol {
    func navigate(to viewController: UIViewController, from viewController: UIViewController)
}


public class RouterHelper: RouterHelperProtcol {
    public func navigate(to viewController: UIViewController, from sourceViewController: UIViewController) {
        sourceViewController.navigationController?.pushViewController(viewController, animated: true)
    }
}
