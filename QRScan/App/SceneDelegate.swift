//
//  SceneDelegate.swift
//  QRScan
//
//  Created by Naratama on 10/08/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        if UserDefaults.standard.object(forKey: "userSaldo") == nil || UserDefaults.standard.object(forKey: "userSaldo") as! Int == 0 {
            UserDefaults.standard.set(150000, forKey: "userSaldo")
        }
        
        if UserDefaults.standard.object(forKey: "userTransaction") == nil {
            UserDefaults.standard.set([] as [[String: Any]], forKey: "userTransaction")
        }
                
        let window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController(rootViewController: HomeRouter.createModule(routeToScanQR: {
            if let topController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
                let scanQRVC = ScanQRRouter.createModule(navigateToPaymentDetailModule: { qrCode in
                    let paymentDetailVC = PaymentDetailRouter.createModule(with: qrCode)
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.7, execute: {
                        topController.visibleViewController?.navigationController?.pushViewController(paymentDetailVC, animated: true)
                    })
                })
                topController.visibleViewController?.navigationController?.pushViewController(scanQRVC, animated: true)
            }
        }, routeToTransactionHistory: {
            if let topController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
                let transactionHistoryVC = TransactionHistoryRouter.createModule()
                topController.visibleViewController?.navigationController?.pushViewController(transactionHistoryVC, animated: false)
            }
        }))
        self.window = window
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

