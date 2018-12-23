//
//  MainController.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 30.10.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

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
