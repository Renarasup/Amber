//
//  ViewController.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 30.10.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit
import RealmSwift
import StoreKit
import PKHUD

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
    private let noApplicationsView = NoApplicationsView()
    
    private let tableView = UITableView()
    
    private let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
    private lazy var blurEffectView = UIVisualEffectView(effect: blurEffect)
    
    private let premiumFeaturesView = UnlockPremiumFeaturesView()
    
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
        
        noApplicationsView.alpha = 0
        
        sortView.delegate = self
        sortView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(onSortPanned(_:))))
        
        blurEffectView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onBlurEffectViewPressed)))
        
        premiumFeaturesView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(handlePurchaseNotification(_:)),
                                               name: .IAPHelperPurchaseNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTransactionFailedNotification(_:)),
                                               name: .IAPHelperTransactionFailedNotification,
                                               object: nil)
        
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
        
        premiumFeaturesView.alpha = 0
        
        sortView.setColors()
        
        noApplicationsView.setColors()
        
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
                filterApplications = SortBy(rawValue: KeyManager.shared.sortBy)?.put(applications: tempApplications) ?? []
            } else {
                filterApplications = SortBy(rawValue: KeyManager.shared.sortBy)?.put(applications: self.applications) ?? []
            }
            UIView.animate(withDuration: 0.25) {
                self.noApplicationsView.alpha = self.filterApplications.count == 0 ? 1 : 0
            }
        } catch let error as NSError {
            self.alert(error: error)
        }
    }
    
    // MARK: - AutoLayout & Views Layouting
    /***************************************************************/
    
    private func setupViewsLayout() {
        view.fillToSuperview(tableView)
        tableView.fillToSuperview(noApplicationsView)
        
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
        
        window.add(subview: premiumFeaturesView) { (v, p) in [
            v.heightAnchor.constraint(equalToConstant: view.frame.height * 0.7),
            v.widthAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.8),
            v.centerXAnchor.constraint(equalTo: p.centerXAnchor),
            v.centerYAnchor.constraint(equalTo: p.centerYAnchor),
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
        if UserDefaults.standard.bool(forKey: Constants.allInOne) || UserDefaults.standard.bool(forKey: Constants.unlimitedApplications) {
            coordinator?.showAddApplicationsScreen()
        } else if filterApplications.count == 5  {
            // show premium
            animatePremiumFeaturesView()
        } else {
            coordinator?.showAddApplicationsScreen()
        }
    }
    
    @objc private func onSortPressed() {
        animateSortView()
    }
    
    @objc private func onSortPanned(_ sender: UIPanGestureRecognizer) {
        if sender.state == .ended {
            if sender.translation(in: sortView).y > 0 {
                sortView.selectedIndex = filterState.rawValue
                sortView.reloadPage()
                deAnimateSortView()
            }
        }
    }
    
    @objc private func onBlurEffectViewPressed() {
        deAnimateSortView()
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
    
    private func animatePremiumFeaturesView() {
        
        premiumFeaturesView.setPackage(.unlimitedApplications)
        
        UIView.animate(withDuration: 0.25) {
            self.blurEffectView.alpha = 1
            self.premiumFeaturesView.alpha = 1
        }
    }
    
    private func deAnimatePremiumFeaturesView() {
        
        UIView.animate(withDuration: 0.25) {
            self.blurEffectView.alpha = 0
            self.premiumFeaturesView.alpha = 0
        }
    }
    
    // MARK: - Notifications
    /***************************************************************/
    
    @objc func handlePurchaseNotification(_ notification: Notification) {
        guard
            let productID = notification.object as? String
            //            let index = products.index(where: { product -> Bool in
            //                product.productIdentifier == productID
            //            })
            else {
                let errorView = PKHUDErrorView(title: "Error", subtitle: "Transaction Failed")
                PKHUD.sharedHUD.contentView = errorView
                PKHUD.sharedHUD.show()
                PKHUD.sharedHUD.hide(afterDelay: 2.0) { success in
                    self.deAnimatePremiumFeaturesView()
                }
                return
        }
        let successView = PKHUDSuccessView(title: "Success", subtitle: "\(Package.get(productID).title) Transaction Complete")
        PKHUD.sharedHUD.contentView = successView
        PKHUD.sharedHUD.show()
        PKHUD.sharedHUD.hide(afterDelay: 2.0) { success in
            self.deAnimatePremiumFeaturesView()
            
        }
    }
    
    @objc func handleTransactionFailedNotification(_ notification: Notification) {
        let errorView = PKHUDErrorView(title: "Error", subtitle: "Transaction Failed")
        PKHUD.sharedHUD.contentView = errorView
        PKHUD.sharedHUD.show()
        PKHUD.sharedHUD.hide(afterDelay: 2.0) { success in
            self.deAnimatePremiumFeaturesView()
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
                realm.delete(filterApplications[indexPath.row])
            }
            
            self.tableView.beginUpdates()
            
            self.filterApplications.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            self.tableView.endUpdates()
            
            UIView.animate(withDuration: 0.25) {
                self.noApplicationsView.alpha = self.filterApplications.count == 0 ? 1 : 0
            }
            
        } catch let error as NSError {
            self.alert(error: error)
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

extension ApplicationsViewController: UnlockPremiumFeaturesViewDelegate {
    func dismiss() {
        deAnimatePremiumFeaturesView()
    }
    
    func didPressBuyAllInOne() {
        
        HUD.show(.progress)
        
        ApplimeProducts.store.requestProducts { (success, products) in
            if success {
                
                guard let products = products else {
                    return
                }
                
                guard let idx = products.firstIndex(where: { (product) -> Bool in
                    if product.productIdentifier == Constants.allInOne {
                        return true
                    }
                    return false
                }) else { return }
                
                ApplimeProducts.store.buyProduct(products[idx])
            }
        }
    }
    
    func didPressViewAllInOnePackage() {
        deAnimatePremiumFeaturesView()
        coordinator?.globallyShowPackageInformationScreen(package: .allInOne)
    }
    
    func didPressBuy(package: Package) {
        
        HUD.show(.progress)
        
        ApplimeProducts.store.requestProducts { (success, products) in
            if success {
                
                guard let products = products else {
                    return
                }
                
                guard let idx = products.firstIndex(where: { (product) -> Bool in
                    if product.productIdentifier == package.productIdentifier {
                        return true
                    }
                    return false
                }) else { return }
                
                ApplimeProducts.store.buyProduct(products[idx])
            }
        }
    }
    
    func didRestorePurchase() {
        HUD.show(.progress)
        
        ApplimeProducts.store.restorePurchases()
    }
}

