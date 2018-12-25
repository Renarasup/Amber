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
import RealmSwift

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
        
        
        // Let Realm handle Migration when adding new properties
        loadRealmConfig()
        
        // Initialize shared list
        CurrencyManager.shared.initialize()
        
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
    
    func loadRealmConfig() {
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 1,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 1) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
        })
        
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
        
        // Now that we've told Realm how to handle the schema change, opening the file
        // will automatically perform the migration
        let _ = try! Realm()
    }
}
