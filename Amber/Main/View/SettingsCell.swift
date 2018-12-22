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
    
//    var delegate: SettingsCellDelegate?
    
    let switchView = UISwitch()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        textLabel?.font = .medium
        detailTextLabel?.font = .medium
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSwitch() {
        accessoryView = switchView
        switchView.addTarget(self, action: #selector(switchTurned(_:)), for: .valueChanged)
    }
    
    @objc private func switchTurned(_ sender: UISwitch) {
//        delegate?.didTurnSwitch(sender)
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
        cell.detailTextLabel?.text = "Date"
    }
    
    func didSelect(settingsVC: SettingsViewController) {
        
    }
}

struct DefaultCurrencyItem: SettingsItem {
    var cellType: SettingsCell.Type {
        return DisclosureCell.self
    }
    
    func configure(cell: SettingsCell) {
        cell.textLabel?.text = "Default Currency"
        cell.detailTextLabel?.text = "EUR (€)"
    }
    
    func didSelect(settingsVC: SettingsViewController) {
        
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
        
    }
}

struct ThemeItem: SettingsItem {
    var cellType: SettingsCell.Type {
        return DisclosureCell.self
    }
    
    func configure(cell: SettingsCell) {
        cell.textLabel?.text = "Theme"
    }
    
    func didSelect(settingsVC: SettingsViewController) {
        
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
