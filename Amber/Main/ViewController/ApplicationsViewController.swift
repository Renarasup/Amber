//
//  ViewController.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 30.10.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit
import RealmSwift

class ApplicationsViewController: BaseViewController {
    
    // Instance Variables
    var coordinator: ApplicationsCoordinator?
    
    private var applications: [Application] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getData()
    }
    
    // MARK: - Networking
    /***************************************************************/
    
    private func getData() {
        do {
            let realm = try Realm()
            self.applications = Array(realm.objects(Application.self))
        } catch let error as NSError {
            
            // handle error
        }
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
        cell.delegate = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let application = applications[indexPath.row]
        coordinator?.showExistingApplicationScreen(application: application)
    }
}

extension ApplicationsViewController: ApplicationCellDelegate {
    func didLongPress(_ longPressGestureRecognizer: UILongPressGestureRecognizer, in cell: UITableViewCell) {
        showAlertForCell(cell)
    }
    
    private func showAlertForCell(_ cell: UITableViewCell) {
        let alertController = UIAlertController(title: "Warning", message: "You are about to delete an application", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (_) in
            guard let indexPath = self.tableView.indexPath(for: cell) else { return }
            self.deleteRows(at: indexPath)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func deleteRows(at indexPath: IndexPath) {
        
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(applications[indexPath.row])
            }
            
            self.tableView.beginUpdates()
            
            self.applications.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            self.tableView.endUpdates()
            
        } catch let error as NSError {
            
            // handle error
        }
    }
}
