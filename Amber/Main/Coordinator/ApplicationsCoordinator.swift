//
//  ApplicationsCoordinator.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 30.10.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if KeyManager.shared.theme == ColorScheme.Light.rawValue {
            return .default
        }
        return .lightContent
    }
}

class ApplicationsCoordinator: Coordinator {
    var childCoordinators: [String : Coordinator] = [:]
    
    var navigationController: CustomNavigationController
    
    init(navigationController: CustomNavigationController) {
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
    
    func showSearchApplicationsToScreen(addApplicationsVC: AddApplicationViewController) {
        let searchApplicationsVC = SearchApplicationToViewController()
        searchApplicationsVC.delegate = addApplicationsVC
        navigationController.present(CustomNavigationController(rootViewController: searchApplicationsVC), animated: true)
    }
    
    func showChooseStateScreen(addApplicationsVC: AddApplicationViewController) {
//        let chooseStateVC = ChooseStateViewController()
//        chooseStateVC.delegate = addApplicationsVC
//        navigationController.present(UINavigationController(rootViewController: chooseStateVC), animated: true)
    }

    func showEditNoteScreen(text: String, addApplicationsVC: AddApplicationViewController) {
        let editNoteVC = EditNoteViewController(text: text)
        editNoteVC.delegate = addApplicationsVC
        navigationController.present(CustomNavigationController(rootViewController: editNoteVC), animated: true)
    }
    
    
    // MARK: - Settings
    /***************************************************************/
    
    func showSettingsScreen() {
        let settingsVC = SettingsViewController()
        settingsVC.coordinator = self
        navigationController.present(CustomNavigationController(rootViewController: settingsVC), animated: true)
    }
    
    func showSortByScreen(settingsVC: SettingsViewController) {
        let sortByVC = SortBySettingsViewController()
        settingsVC.navigationController?.pushViewController(sortByVC, animated: true)
    }
    
    func showDefaultCurrencyScreen(settingsVC: SettingsViewController) {
        let defaultCurrencyVC = DefaultCurrencySettingsViewController()
        settingsVC.navigationController?.pushViewController(defaultCurrencyVC, animated: true)
    }
    
    func showThemeScreen(settingsVC: SettingsViewController) {
        let themeVC = ThemeSettingsViewController()
        settingsVC.navigationController?.pushViewController(themeVC, animated: true)
    }
    
    func showStateColorsScreen(settingsVC: SettingsViewController) {
        let stateColorsVC = StateColorSettingsViewController(settingsVC: settingsVC)
        stateColorsVC.coordinator = self
        settingsVC.navigationController?.pushViewController(stateColorsVC, animated: true)
    }
    
    func showChooseStateColorsScreen(settingsVC: SettingsViewController, state: Application.StateType) {
        let stateColorsVC = ChooseStateColorViewController(state: state)
        settingsVC.navigationController?.pushViewController(stateColorsVC, animated: true)
    }
    
    func showAboutUsScreen(settingsVC: SettingsViewController) {
        let aboutUsVC = AboutUsSettingsViewController()
        settingsVC.navigationController?.pushViewController(aboutUsVC, animated: true)
    }
}
