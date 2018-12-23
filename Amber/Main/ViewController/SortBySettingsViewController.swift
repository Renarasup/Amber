//
//  SortBySettingsViewController.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 23.12.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class SortBySettingsViewController: BaseViewController {
    
    private let tableView = UITableView()
    private let all = SortBy.all
    
    // KeyManager
    private var selectedIndex = KeyManager.shared.sortBy {
        didSet {
            KeyManager.shared.sortBy = selectedIndex
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self)
        tableView.tableFooterView = UIView()
        
        view.fillToSuperview(tableView)
    }
    
    override func setupUI() {
        super.setupUI()
        
        view.backgroundColor = .white
        
        // Add Title Label
        let titleLabel = BaseLabel(text: "Sort By", font: .regular, textColor: .black, numberOfLines: 1)
        navigationItem.titleView = titleLabel
    }
}

extension SortBySettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return all.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(UITableViewCell.self, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.textLabel?.font = .medium
        cell.textLabel?.text = all[indexPath.row].title
        
        if indexPath.row == selectedIndex {
            cell.accessoryType = .checkmark
            cell.tintColor = .Highlight
        }  else {
            cell.accessoryType = .none
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}
