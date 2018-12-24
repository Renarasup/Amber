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
    
    private var sortHeight: NSLayoutConstraint!
    
    // Filter
    private var filterApplications: [Application] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    private var filterState: Application.StateType = .All

    // UI Views
    private let tableView = UITableView()
    
    private let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
    private lazy var blurEffectView = UIVisualEffectView(effect: blurEffect)
    
    private let sortView = SortView()
    
    private let titleLabel = BaseLabel(text: "My Applications", font: .regular, textColor: .black, numberOfLines: 1)
    
    private lazy var settingsBarItem = UIBarButtonItem(image: #imageLiteral(resourceName: "settings").withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(onSettingsPressed))
    private lazy var  addApplicationBarItem = UIBarButtonItem(image: #imageLiteral(resourceName: "add-plus").withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(onAddApplicationsPressed))
    private lazy var  sortBarItem = UIBarButtonItem(image: #imageLiteral(resourceName: "filter").withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(onSortPressed))
    
    // MARK: - Setup Core Components & Delegations
    /***************************************************************/

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ApplicationMainCell.self)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
        sortView.delegate = self
        sortView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(onSortPanned(_:))))

        setupViewsLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = .Main
        tableView.backgroundColor = .Secondary
        tableView.separatorColor = .SettingsCell
        titleLabel.textColor = .Tint
        
        settingsBarItem.tintColor = .Tint
        addApplicationBarItem.tintColor = .Tint
        sortBarItem.tintColor = .Tint
        
        sortView.setColors()
    
        getData()
    }
    
    // MARK: - Networking
    /***************************************************************/
    
    private func getData() {
        do {
            let realm = try Realm()
            self.applications = Array(realm.objects(Application.self))
            
            if filterState != .All {
                let tempApplications = applications.filter { (application) -> Bool in
                    if application.state == filterState.rawValue {
                        return true
                    }
                    return false
                }
                
                filterApplications = tempApplications
            } else {
                filterApplications = self.applications
            }
            
//            tableHeader.setState(filterState, filteredNumOfApplications: filterApplications.count, totalNumOfApplications: applications.count)
            
        } catch let error as NSError {
            // handle error
            
        }
    }
    
    // MARK: - AutoLayout & Views Layouting
    /***************************************************************/

    private func setupViewsLayout() {
        view.fillToSuperview(tableView)
        
        // Setup Blur View for sorting
        let window = UIApplication.shared.keyWindow!
        blurEffectView.frame = window.bounds
        window.addSubview(blurEffectView)

        window.add(subview: sortView) { (v, p) in [
            v.heightAnchor.constraint(equalToConstant: view.frame.height * 0.6),
            v.bottomAnchor.constraint(equalTo: p.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.padding + 5),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: Constants.padding - 5),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor, constant: -Constants.padding + 5),
            ]}
    }
    
    // MARK: - Basic UI Setup
    /***************************************************************/

    override func setupUI() {
        super.setupUI()
        
        view.backgroundColor = .white
        
        // BlurView
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0
        
        // Sort View
        sortView.alpha = 0
        
        // Add Title Label
        navigationItem.titleView = titleLabel
        
        // Setup Navigation Items
        navigationItem.leftBarButtonItem = settingsBarItem
        navigationItem.rightBarButtonItems = [addApplicationBarItem, sortBarItem]
    }
    
    
    // MARK: - On Pressed Handlers
    /***************************************************************/
    
    @objc private func onSettingsPressed() {
        coordinator?.showSettingsScreen()
    }
    
    @objc private func onAddApplicationsPressed() {
        coordinator?.showAddApplicationsScreen()
    }
    
    @objc private func onSortPressed() {
        animateSortView()
    }
    var prevTranslationY: CGFloat = 0
    var currTranslationY: CGFloat = 0
    
    @objc private func onSortPanned(_ sender: UIPanGestureRecognizer) {
        if sender.state == .ended {
            if sender.translation(in: sortView).y > 0 {
                sortView.selectedIndex = filterState.rawValue
                sortView.reloadPage()
                deAnimateSortView()
            }
        }
    }
    
    // MARK: - Animations
    /***************************************************************/
    
    private func animateSortView() {
        
        UIView.animate(withDuration: 0.25) {
            self.blurEffectView.alpha = 1
            self.sortView.alpha = 1
        }
    }
    
    private func deAnimateSortView() {
        
        UIView.animate(withDuration: 0.25) {
            self.blurEffectView.alpha = 0
            self.sortView.alpha = 0
        }
    }
}

// MARK: - UITableView Delegate & DataSource Extension
/***************************************************************/

extension ApplicationsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterApplications.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.height * 0.22
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(ApplicationMainCell.self, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let cell = cell as! ApplicationMainCell
        
        let application = filterApplications[indexPath.row]
        cell.model = application
        cell.delegate = self
        cell.backgroundColor = .Main
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let application = filterApplications[indexPath.row]
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

extension ApplicationsViewController: SortViewDelegate {
    
    func didChooseState(_ sortView: SortView, state: Application.StateType) {
        filterState = state
        
        // Refresh
        getData()
        
        deAnimateSortView()
    }
}
