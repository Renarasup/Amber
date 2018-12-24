//
//  Settings.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 22.12.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

protocol SettingsItem {
    var cellType: SettingsCell.Type { get }
    func configure(cell: SettingsCell)
    func didSelect(settingsVC: SettingsViewController)
}

struct SettingsSection {
    var title: String?
    var items: [SettingsItem]
    var footer: String?
}
