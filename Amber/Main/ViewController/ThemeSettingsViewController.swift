//
//  ThemeSettingsViewController.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 23.12.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class ThemeSettingsViewController: BaseViewController {
    
    private let titleLabel = BaseLabel(text: "Sort By", font: .regular, textColor: .Tint, numberOfLines: 1)
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let all = ["Light", "Dark"]
    
    
    func getSelectedIndex() -> Int {
        return all.firstIndex(where: { (theme) -> Bool in
            if theme == KeyManager.shared.theme {
                return true
            }
            return false
        }) ?? 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self)
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .Secondary
        tableView.separatorColor = .SettingsCell

        view.fillToSuperview(tableView)
    }
    
    override func setupUI() {
        super.setupUI()
        
        view.backgroundColor = .Main
        
        // Add Title Label
        navigationItem.titleView = titleLabel
    }
    
    func changeSchemeTo(cs: ColorScheme){
        UIColor.initWithColorScheme(cs: cs)
        
        UIView.animate(withDuration: 0.25) {
            self.view.backgroundColor = .Main
            self.tableView.backgroundColor = .Secondary
            self.tableView.separatorColor = .SettingsCell
            self.titleLabel.textColor = .Tint
            self.navigationController?.navigationBar.tintColor = .Tint
        }
    }
}

extension ThemeSettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Theme"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont.regular.withSize(13)
        header.textLabel?.textColor = .TableViewHeader
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return all.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(UITableViewCell.self, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.textLabel?.font = .medium
        cell.textLabel?.text = all[indexPath.row]
        cell.textLabel?.textColor = .Tint
        cell.backgroundColor = .SettingsCell
        
        if indexPath.row == getSelectedIndex() {
            cell.accessoryType = .checkmark
            cell.tintColor = .HighlightTint
        }  else {
            cell.accessoryType = .none
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        KeyManager.shared.theme = all[indexPath.row]
        
        changeSchemeTo(cs: ColorScheme(rawValue: all[indexPath.row]) ?? .Light)
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}
