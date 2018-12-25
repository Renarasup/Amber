//
//  PackagesViewController.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 24.12.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit
import StoreKit

class PackagesViewController: BaseViewController {
    
    var coordinator: ApplicationsCoordinator?
    
    private let all = Package.all
    private let tableView = UITableView()
    
    private var products: [SKProduct]! {
        didSet {
            tableView.reloadData()
        }
    }
    
    // Needed to stay at root navController which is settingsVC in this case
    private var settingsVC: SettingsViewController!
    
    init(settingsVC: SettingsViewController, products: [SKProduct]) {
        super.init(nibName: nil, bundle: nil)
        self.settingsVC = settingsVC
        self.products = products
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PackageCell.self)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .Main
        
        view.fillToSuperview(tableView)
    }
    
    override func setupUI() {
        super.setupUI()
        
        let titleLabel = BaseLabel(text: "Packages", font: .regular, textColor: .Tint, numberOfLines: 1)
        navigationItem.titleView = titleLabel
    }
}

extension PackagesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(PackageCell.self, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! PackageCell
        
        cell.delegate = self
        
        if let products = products {
            cell.model = products[indexPath.row]
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 2.15
    }
}

extension PackagesViewController: PackageCellDelegate {
    
    func didView(package: Package) {
        coordinator?.showPackageInformationScreen(settingsVC: settingsVC, package: package)
    }
    
    func didBuy(package: Package, product: SKProduct) {
        ApplimeProducts.store.buyProduct(product)
    }
}
