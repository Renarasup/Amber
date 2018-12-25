//
//  ThemeSettingsViewController.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 23.12.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit
import PKHUD

class ThemeSettingsViewController: BaseViewController {
    
    var coordinator: ApplicationsCoordinator?
    
    var settingsVC: SettingsViewController!
    
    private let footerView = ThemeFooterView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.4))
    
    private let titleLabel = BaseLabel(text: "Sort By", font: .regular, textColor: .Tint, numberOfLines: 1)
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let all = ["Light", "Dark"]
    
    private let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
    private lazy var blurEffectView = UIVisualEffectView(effect: blurEffect)
    
    private let premiumFeaturesView = UnlockPremiumFeaturesView()
    
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
        tableView.backgroundColor = .Secondary
        tableView.separatorColor = .SettingsCell
//        tableView.tableFooterView = footerView
        
        premiumFeaturesView.delegate = self
        
        premiumFeaturesView.alpha = 0
        blurEffectView.alpha = 0
        
        NotificationCenter.default.addObserver(self, selector: #selector(handlePurchaseNotification(_:)),
                                               name: .IAPHelperPurchaseNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTransactionFailedNotification(_:)),
                                               name: .IAPHelperTransactionFailedNotification,
                                               object: nil)

        view.fillToSuperview(tableView)
        
        // Setup Blur View
        let window = UIApplication.shared.keyWindow!
        blurEffectView.frame = window.bounds
        window.addSubview(blurEffectView)
        
        window.add(subview: premiumFeaturesView) { (v, p) in [
            v.heightAnchor.constraint(equalToConstant: view.frame.height * 0.7),
            v.widthAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.8),
            v.centerXAnchor.constraint(equalTo: p.centerXAnchor),
            v.centerYAnchor.constraint(equalTo: p.centerYAnchor),
            ]}
    }
    
    override func setupUI() {
        super.setupUI()
        
        view.backgroundColor = .Main
        
        // Add Title Label
        navigationItem.titleView = titleLabel
    }
    
    private func animatePremiumFeaturesView() {
        
        premiumFeaturesView.setPackage(.design)
        
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
    
    @objc func handlePurchaseNotification(_ notification: Notification) {
        guard
            let _ = notification.object as? String
            //            let index = products.index(where: { product -> Bool in
            //                product.productIdentifier == productID
            //            })
            else {
                let errorView = PKHUDErrorView(title: "Error", subtitle: "Restoration Failed")
                PKHUD.sharedHUD.contentView = errorView
                PKHUD.sharedHUD.show()
                PKHUD.sharedHUD.hide(afterDelay: 2.0) { (success) in
                    self.deAnimatePremiumFeaturesView()
                }
                return
        }
        let successView = PKHUDSuccessView(title: "Success", subtitle: "Restoration Complete")
        PKHUD.sharedHUD.contentView = successView
        PKHUD.sharedHUD.show()
        PKHUD.sharedHUD.hide(afterDelay: 2.0) { (success) in
            self.deAnimatePremiumFeaturesView()
        }
    }
    
    @objc func handleTransactionFailedNotification(_ notification: Notification) {
        let errorView = PKHUDErrorView(title: "Error", subtitle: "Restoration Failed")
        PKHUD.sharedHUD.contentView = errorView
        PKHUD.sharedHUD.show()
        PKHUD.sharedHUD.hide(afterDelay: 2.0) { (success) in
            self.deAnimatePremiumFeaturesView()
        }
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
        
        setNeedsStatusBarAppearanceUpdate()
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
        if all[indexPath.row] != "Light" {
            if UserDefaults.standard.bool(forKey: Constants.allInOne) || UserDefaults.standard.bool(forKey: Constants.customizeDesign) {
                KeyManager.shared.theme = all[indexPath.row]
                changeSchemeTo(cs: ColorScheme(rawValue: all[indexPath.row]) ?? .Light)
            } else {
                // Show Unlock Premium Features
                animatePremiumFeaturesView()
            }
        } else {
            KeyManager.shared.theme = all[indexPath.row]
            changeSchemeTo(cs: ColorScheme(rawValue: all[indexPath.row]) ?? .Light)
        }

        
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}

extension ThemeSettingsViewController: UnlockPremiumFeaturesViewDelegate {
    
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
        
        coordinator?.globallyShowPackageInformationScreen(settingsVC: settingsVC, package: .allInOne)
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
