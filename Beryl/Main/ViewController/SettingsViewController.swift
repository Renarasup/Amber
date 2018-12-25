//
//  SettingsViewController.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 02.11.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit
import SwiftyStoreKit
import MessageUI

class SettingsViewController: BaseViewController {
    
    var coordinator: ApplicationsCoordinator?
    
    private var model = [SettingsSection]()

    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    lazy var dropDownBarItem = UIBarButtonItem(image: #imageLiteral(resourceName: "drop_down").withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(onDropDownPressed))
    let titleLabel = BaseLabel(text: "Settings", font: .regular, textColor: .Tint, numberOfLines: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self)
        
        let footerView = FooterView(frame: CGRect(x: 0, y: 0, width: 0, height: 80))
        tableView.tableFooterView = footerView
        
        NotificationCenter.default.addObserver(self, selector: #selector(handlePurchaseNotification(_:)),
                                               name: .IAPHelperPurchaseNotification,
                                               object: nil)
        
        view.fillToSuperview(tableView)
                
        updateView()
    }
    
    @objc func handlePurchaseNotification(_ notification: Notification) {
        guard
            let productID = notification.object as? String
//            let index = products.index(where: { product -> Bool in
//                product.productIdentifier == productID
//            })
            else {
                self.alert(title: "Error", message: "Nothing to restore", cancelable: false, handler: nil)

                return
        }
        
        self.alert(title: "Success", message: "\(Package.get(productID).title) restored", cancelable: false, handler: nil)
    }
    
    func updateView() {
        let myApplicationsSection = SettingsSection(title: "My Applications", items: [ SortApplicationsByItem(), DefaultCurrencyItem() ], footer: nil)
        let designSection = SettingsSection(title: "Design", items: [ ApplicationStateColorItem(), ThemeItem() ], footer: nil)
        let purchasesSection = SettingsSection(title: "Purchases", items: [ RestorePurchasesItem(), ViewPackagesItem() ], footer: nil)
        let infoSection = SettingsSection(title: "Info", items: [ FeedbackItem(), AboutUsItem(), RateUsItem() ], footer: nil)
        
        model = [ myApplicationsSection, designSection, purchasesSection, infoSection ]
        
        for section in model {
            for item in section.items {
                tableView.register(item.cellType, forCellReuseIdentifier: item.cellType.defaultReuseIdentifier)
            }
        }
        
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = .Main
        tableView.backgroundColor = .Secondary
        tableView.separatorColor = .SettingsCell
        dropDownBarItem.tintColor = .Tint
        titleLabel.textColor = .Tint
        
        tableView.reloadData()
    }

    override func setupUI() {
        super.setupUI()
        
        // Add Dropdown
        navigationItem.leftBarButtonItem = dropDownBarItem
        
        
        // Add Title Label
        navigationItem.titleView = titleLabel
    }
    
    @objc private func onDropDownPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    func restorePurchase() {
        ApplimeProducts.store.restorePurchases()
//        SwiftyStoreKit.restorePurchases(atomically: true) { results in
//            if results.restoreFailedPurchases.count > 0 {
//                self.alert(title: "Restore Fail", message: "\(results.restoreFailedPurchases)", cancelable: false, handler: nil)
//            }
//            else if results.restoredPurchases.count > 0 {
//                self.alert(title: "Restore Success", message: "\(results.restoredPurchases)", cancelable: false, handler: nil)
//            }
//            else {
//                self.alert(title: "Error", message: "Nothing to restore", cancelable: false, handler: nil)
//            }
//        }
    }
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["giancarlo_buenaflor@yahoo.com"])
            mail.setMessageBody("<p>About Amber:</p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            self.alert(title: "Error", message: "Something went wrong!", cancelable: false, handler: nil)
        }
    }
    
    func rateApp(appId: String, completion: @escaping ((_ success: Bool)->())) {
        guard let url = URL(string : "itms-apps://itunes.apple.com/app/" + appId) else {
            completion(false)
            return
        }
        guard #available(iOS 10, *) else {
            completion(UIApplication.shared.openURL(url))
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: completion)
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
        header.textLabel?.textColor = .TableViewHeader
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
        
        cell.textLabel?.textColor = .Tint
        cell.textLabel?.font = .medium
        cell.detailTextLabel?.font = .medium
        cell.backgroundColor = .SettingsCell

        item.configure(cell: cell)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        model[indexPath.section].items[indexPath.row].didSelect(settingsVC: self)
        
        tableView.deselectRow()
    }
}

extension SettingsViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
