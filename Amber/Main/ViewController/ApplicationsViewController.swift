//
//  ViewController.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 30.10.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class ApplicationsViewController: BaseViewController {
    
    // Instance Variables
    var coordinator: ApplicationsCoordinator?
    
    private var applications: [Application] = []
    
    // UI Views
    private let tableView = UITableView()

    
    // MARK: - Setup Core Components & Delegations
    /***************************************************************/

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ApplicationCell.self)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
        view.fillToSuperview(tableView)
        
        getData()
    }
    
    // MARK: - Networking
    /***************************************************************/
    private func getData() {
        let data = Application(state: .Applied, applicationToTitle: "Microsoft", sentDate: "01.11.2018", jobTitle: "iOS Developer", salary: 28000, zipCode: "1220 Wien", note: nil, imageLink: nil, rejectedDate: nil)
        
        let data2 = Application(state: .Interview, applicationToTitle: "Google", sentDate: "01.11.2018", jobTitle: "Android Developer", salary: 28000, zipCode: "1020 Wien", note: nil, imageLink: nil, rejectedDate: nil)
        
        applications.append(data)
        applications.append(data2)
        tableView.reloadData()
    }
    
    
    // MARK: - Basic UI Setup
    /***************************************************************/

    override func setupUI() {
        super.setupUI()
        
        view.backgroundColor = .white
        
        // Add Title Label
        let titleLabel = BaseLabel(text: "My Applications", font: .regular, textColor: .black, numberOfLines: 1)
        navigationItem.titleView = titleLabel
        
        // Setup Navigation Items
        let settingsBarItem = UIBarButtonItem(image: #imageLiteral(resourceName: "settings").withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(onSettingsPressed))
        let addApplicationBarItem = UIBarButtonItem(image: #imageLiteral(resourceName: "add-plus").withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(onAddApplicationsPressed))
        
        settingsBarItem.tintColor = .darkGray
        addApplicationBarItem.tintColor = .darkGray
        
        navigationItem.leftBarButtonItem = settingsBarItem
        navigationItem.rightBarButtonItem = addApplicationBarItem
    }
    
    
    // MARK: - On Pressed Handlers
    /***************************************************************/
    
    @objc private func onSettingsPressed() {
        coordinator?.showSettingsScreen()
    }
    
    @objc private func onAddApplicationsPressed() {
        coordinator?.showAddApplicationsScreen()
    }
}

// MARK: - UITableView Delegate & DataSource Extension
/***************************************************************/

extension ApplicationsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return applications.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.height * 0.2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(ApplicationCell.self, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let cell = cell as! ApplicationCell
        
        let application = applications[indexPath.row]
        cell.model = application
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
