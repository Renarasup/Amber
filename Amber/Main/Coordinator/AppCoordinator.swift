//
//  AppCoordinator.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 30.10.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators: [String : Coordinator] = [:]
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let applicationCoordinator = ApplicationsCoordinator(navigationController: navigationController)
        let className = NSStringFromClass(ApplicationsCoordinator.self)
        childCoordinators[className] = applicationCoordinator
        applicationCoordinator.start()
    }
}
