//
//  MainController.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 30.10.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import SwiftyStoreKit

class AppController {
    
    static let shared = AppController()
    
    private var coordinator: AppCoordinator?
    private var window: UIWindow!
    
    private var rootViewController: UINavigationController? {
        didSet {
            if let vc = rootViewController {
                window.rootViewController = vc
            }
        }
    }
    
    // MARK: Helpers
    
    func show(in window: UIWindow?) {
        guard let window = window else {
            fatalError("Cannot layout app with a nil window.")
        }
        
        // Handle StoreKit
        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
            for purchase in purchases {
                switch purchase.transaction.transactionState {
                case .purchased, .restored:
                    if purchase.needsFinishTransaction {
                        // Deliver content from server, then:
                        SwiftyStoreKit.finishTransaction(purchase.transaction)
                    }
                // Unlock content
                case .failed, .purchasing, .deferred:
                    break // do nothing
                }
            }
        }
        
        // Initialize color scheme
        UIColor.initWithColorScheme(cs: ColorScheme(rawValue: KeyManager.shared.theme) ?? .Light)
        
        // Keyboard handling
        IQKeyboardManager.shared.enable = true
        
        // Windows Setup
        self.window = window
        window.backgroundColor = .white
        
        // Coordinator Setup
        let navController = CustomNavigationController()
        
        coordinator = AppCoordinator(navigationController: navController)
        coordinator?.start()
        
        rootViewController = navController
        
        window.makeKeyAndVisible()
    }
}
