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
        let addApplicationsVC = AddApplicationViewController()
        addApplicationsVC.coordinator = self
        navigationController.pushViewController(addApplicationsVC, animated: true)
    }
    
    func showExistingApplicationScreen(application: Application) {
        let addApplicationsVC = AddApplicationViewController(application: application)
        addApplicationsVC.coordinator = self
        navigationController.pushViewController(addApplicationsVC, animated: true)
    }
    
    func showSettingsScreen() {
        let settingsVC = SettingsViewController()
        settingsVC.coordinator = self
        navigationController.present(UINavigationController(rootViewController: settingsVC), animated: true)
    }
    
    func showSearchApplicationsToScreen(addApplicationsVC: AddApplicationViewController) {
        let searchApplicationsVC = SearchApplicationToViewController()
        searchApplicationsVC.delegate = addApplicationsVC
        navigationController.present(UINavigationController(rootViewController: searchApplicationsVC), animated: true)
    }
    
    func showChooseStateScreen(addApplicationsVC: AddApplicationViewController) {
//        let chooseStateVC = ChooseStateViewController()
//        chooseStateVC.delegate = addApplicationsVC
//        navigationController.present(UINavigationController(rootViewController: chooseStateVC), animated: true)
    }
    
    // For Filter purpose
    func showChooseStateScreen(applicationVC: ApplicationsViewController) {
        let chooseStateVC = ChooseStateViewController()
        chooseStateVC.delegate = applicationVC
        chooseStateVC.addAllFilterState()
        navigationController.present(UINavigationController(rootViewController: chooseStateVC), animated: true)
    }

    func showEditNoteScreen(text: String, addApplicationsVC: AddApplicationViewController) {
        let editNoteVC = EditNoteViewController(text: text)
        editNoteVC.delegate = addApplicationsVC
        navigationController.present(UINavigationController(rootViewController: editNoteVC), animated: true)
    }
    
    func showSortByScreen(settingsVC: SettingsViewController) {
        let sortByVC = SortBySettingsViewController()
        settingsVC.navigationController?.pushViewController(sortByVC, animated: true)
    }
    
    func showDefaultCurrencyScreen(settingsVC: SettingsViewController) {
        let defaultCurrencyVC = DefaultCurrencySettingsViewController()
        settingsVC.navigationController?.pushViewController(defaultCurrencyVC, animated: true)
    }
}
