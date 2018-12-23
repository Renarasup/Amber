//
//  DefaultCurrencySettingsViewController.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 23.12.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class DefaultCurrencySettingsViewController: BaseViewController {
    
    private let tableView = UITableView()
    
    // KeyManager
    private var allCurrencies: [String]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    func getSelectedIndex() -> Int {
        return allCurrencies?.firstIndex(where: { (currency) -> Bool in
            if currency == KeyManager.shared.defaultCurrency {
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
        
        view.fillToSuperview(tableView)
        
        loadCurrency()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let indexPath = IndexPath(row: self.getSelectedIndex(), section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
        }
    }
    
    func loadCurrency() {
        CurrencyManager.loadCurrencyList { (response) in
            var allCurrencies = [String]()
            for currency in response {
                let symbol = currency.value.symbol
                let code = currency.value.code
                
                allCurrencies.append("\(code) (\(symbol))")
            }
            self.allCurrencies = allCurrencies.sorted()
        }
    }
    
    override func setupUI() {
        super.setupUI()
        
        view.backgroundColor = .white
        
        // Add Title Label
        let titleLabel = BaseLabel(text: "Default Currency", font: .regular, textColor: .black, numberOfLines: 1)
        navigationItem.titleView = titleLabel
    }
}

extension DefaultCurrencySettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let allCurrencies = allCurrencies else {
            return 0
        }
        return allCurrencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(UITableViewCell.self, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let allCurrencies = allCurrencies else {
            return
        }
        cell.textLabel?.font = .medium
        cell.textLabel?.text = allCurrencies[indexPath.row]
        
        if indexPath.row == getSelectedIndex() {
            cell.accessoryType = .checkmark
            cell.tintColor = .Highlight
        }  else {
            cell.accessoryType = .none
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        KeyManager.shared.defaultCurrency = allCurrencies?[indexPath.row] ?? "EUR (€)"
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}

