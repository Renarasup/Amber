//
//  ApplicationsCoordinator.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 30.10.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class ApplicationsCoordinator: Coordinator {
    var childCoordinators: [String : Coordinator] = [:]
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let applicationsVC = ApplicationsViewController()
        applicationsVC.coordinator = self
        navigationController.pushViewController(applicationsVC, animated: true)
    }
    
    func showAddApplicationsScreen() {
        let addApplicationsVC = AddApplicationsViewController()
        addApplicationsVC.coordinator = self
        navigationController.pushViewController(addApplicationsVC, animated: true)
    }
    
    func showSettingsScreen() {
        let settingsVC = SettingsViewController()
        settingsVC.coordinator = self
        navigationController.present(UINavigationController(rootViewController: settingsVC), animated: true)
    }
    
    func showSearchApplicationsToScreen(addApplicationsVC: AddApplicationsViewController) {
        let searchApplicationsVC = SearchApplicationToViewController()
        searchApplicationsVC.delegate = addApplicationsVC
        navigationController.present(UINavigationController(rootViewController: searchApplicationsVC), animated: true)
    }
}
