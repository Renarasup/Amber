//
//  SettingsCell.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 22.12.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

// MARK: - Basic Cell Setup
/***************************************************************/


class SettingsCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DisclosureCell: SettingsCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - General
/***************************************************************/


// MARK: - My Applications
/***************************************************************/

struct SortApplicationsByItem: SettingsItem {
    var cellType: SettingsCell.Type {
        return DisclosureCell.self
    }
    
    func configure(cell: SettingsCell) {
        cell.textLabel?.text = "Sort Applications by"
        cell.detailTextLabel?.text = SortBy(rawValue: KeyManager.shared.sortBy)?.title
    }
    
    func didSelect(settingsVC: SettingsViewController) {
        settingsVC.coordinator?.showSortByScreen(settingsVC: settingsVC)
    }
}

struct DefaultCurrencyItem: SettingsItem {
    var cellType: SettingsCell.Type {
        return DisclosureCell.self
    }
    
    func configure(cell: SettingsCell) {
        cell.textLabel?.text = "Default Currency"
        cell.detailTextLabel?.text = KeyManager.shared.defaultCurrency
    }
    
    func didSelect(settingsVC: SettingsViewController) {
        settingsVC.coordinator?.showDefaultCurrencyScreen(settingsVC: settingsVC)
    }
}


// MARK: - Design
/***************************************************************/

struct ApplicationStateColorItem: SettingsItem {
    var cellType: SettingsCell.Type {
        return DisclosureCell.self
    }
    
    func configure(cell: SettingsCell) {
        cell.textLabel?.text = "State Colors"
    }
    
    func didSelect(settingsVC: SettingsViewController) {
        settingsVC.coordinator?.showStateColorsScreen(settingsVC: settingsVC)
    }
}

struct ThemeItem: SettingsItem {
    var cellType: SettingsCell.Type {
        return DisclosureCell.self
    }
    
    func configure(cell: SettingsCell) {
        cell.textLabel?.text = "Theme"
        cell.detailTextLabel?.text = KeyManager.shared.theme
    }
    
    func didSelect(settingsVC: SettingsViewController) {
        settingsVC.coordinator?.showThemeScreen(settingsVC: settingsVC)
    }
}


// MARK: - Purchases
/***************************************************************/

struct RestorePurchasesItem: SettingsItem {
    var cellType: SettingsCell.Type {
        return SettingsCell.self
    }
    
    func configure(cell: SettingsCell) {
        cell.textLabel?.text = "Restore Purchases"
    }
    
    func didSelect(settingsVC: SettingsViewController) {
        
    }
}


// MARK: - Info
/***************************************************************/

struct FeedbackItem: SettingsItem {
    var cellType: SettingsCell.Type {
        return DisclosureCell.self
    }
    
    func configure(cell: SettingsCell) {
        cell.textLabel?.text = "Feedback"
        cell.detailTextLabel?.text = "giancarlo_buenaflor@yahoo.com"
    }
    
    func didSelect(settingsVC: SettingsViewController) {
        
    }
}

struct AboutUsItem: SettingsItem {
    var cellType: SettingsCell.Type {
        return DisclosureCell.self
    }
    
    func configure(cell: SettingsCell) {
        cell.textLabel?.text = "About Us"
    }
    
    func didSelect(settingsVC: SettingsViewController) {
        
    }
}

struct RateUsItem: SettingsItem {
    var cellType: SettingsCell.Type {
        return DisclosureCell.self
    }
    
    func configure(cell: SettingsCell) {
        cell.textLabel?.text = "Rate this app"
    }
    
    func didSelect(settingsVC: SettingsViewController) {
        
    }
}
