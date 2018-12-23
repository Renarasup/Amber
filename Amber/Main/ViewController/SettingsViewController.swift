//
//  SettingsViewController.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 02.11.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class SettingsViewController: BaseViewController {
    
    var coordinator: ApplicationsCoordinator?
    
    private var model = [SettingsSection]()

    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self)
        tableView.backgroundColor = UIColor(rgb: 0xF7F7F7)
        
        view.fillToSuperview(tableView)
        
        updateView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.reloadData()
    }
    
    func updateView() {
        let myApplicationsSection = SettingsSection(title: "My Applications", items: [ SortApplicationsByItem(), DefaultCurrencyItem() ], footer: nil)
        let designSection = SettingsSection(title: "Design", items: [ ApplicationStateColorItem(), ThemeItem() ], footer: nil)
        let purchasesSection = SettingsSection(title: "Purchases", items: [ RestorePurchasesItem(), ThemeItem() ], footer: nil)
        let infoSection = SettingsSection(title: "Info", items: [ FeedbackItem(), AboutUsItem(), RateUsItem() ], footer: nil)
        
        model = [ myApplicationsSection, designSection, purchasesSection, infoSection ]
        
        for section in model {
            for item in section.items {
                tableView.register(item.cellType, forCellReuseIdentifier: item.cellType.defaultReuseIdentifier)
            }
        }
        
        tableView.reloadData()
    }
    
    override func setupUI() {
        super.setupUI()
        
        view.backgroundColor = .white
        
        // Add Dropdown
        let dropDownBarItem = UIBarButtonItem(image: #imageLiteral(resourceName: "drop_down").withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(onDropDownPressed))
        dropDownBarItem.tintColor = .darkGray
        navigationItem.leftBarButtonItem = dropDownBarItem
        
        
        // Add Title Label
        let titleLabel = BaseLabel(text: "Settings", font: .regular, textColor: .black, numberOfLines: 1)
        navigationItem.titleView = titleLabel
    }
    
    @objc private func onDropDownPressed() {
        dismiss(animated: true, completion: nil)
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func itemAt(indexPath: IndexPath) -> SettingsItem {
        return model[indexPath.section].items[indexPath.row]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont.regular.withSize(13)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model[section].items.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return model[section].title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = itemAt(indexPath: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: item.cellType.defaultReuseIdentifier, for: indexPath) as? SettingsCell else {
            return UITableViewCell()
        }
        
        item.configure(cell: cell)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        model[indexPath.section].items[indexPath.row].didSelect(settingsVC: self)
        
        tableView.deselectRow()
    }
}
