//
//  ChooseStateViewController.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 04.11.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit
import PKHUD

protocol ChooseStateColorViewControllerDelegate: class {
    func didChooseStateColor(_ chooseStateViewController: ChooseStateColorViewController, state: Application.StateType, color: UIColor)
}

class ChooseStateColorViewController: BaseViewController {
    
    var coordinator: ApplicationsCoordinator?
    
    var settingsVC: SettingsViewController!
    
    weak var delegate: ChooseStateColorViewControllerDelegate?
    
    private let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
    private lazy var blurEffectView = UIVisualEffectView(effect: blurEffect)
    
    private let premiumFeaturesView = UnlockPremiumFeaturesView()
    
    private let cvHeaderTitleLabel = BaseLabel(text: "COLORS", font: UIFont.regular.withSize(13), textColor: .TableViewHeader, numberOfLines: 1)
    private let cvPreviewTitleLabel = BaseLabel(text: "PREVIEW", font: UIFont.regular.withSize(13), textColor: .TableViewHeader, numberOfLines: 1)

    // UI Views
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    private var all = [ChooseStateColor]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private let previewCell = ApplicationMainCell(frame: .zero)

    private var state = Application.StateType.Applied
    
    init(state: Application.StateType) {
        super.init(nibName: nil, bundle: nil)
        
        self.state = state
        all = state.multiColors
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ChooseStateColorCell.self)
        collectionView.backgroundColor = .Main
        
        premiumFeaturesView.alpha = 0
        blurEffectView.alpha = 0
        
        premiumFeaturesView.delegate = self
        
        previewCell.injectPreviewData(state: state)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handlePurchaseNotification(_:)),
                                               name: .IAPHelperPurchaseNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTransactionFailedNotification(_:)),
                                               name: .IAPHelperTransactionFailedNotification,
                                               object: nil)
        
        view.add(subview: cvHeaderTitleLabel) { (v, p) in [
            v.topAnchor.constraint(equalTo: p.safeAreaLayoutGuide.topAnchor, constant: Constants.padding),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: Constants.padding)
            ]}
        
        view.add(subview: collectionView) { (v, p) in [
            v.topAnchor.constraint(equalTo: cvHeaderTitleLabel.bottomAnchor, constant: 5),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.45)
            ]}
        
        view.add(subview: cvPreviewTitleLabel) { (v, p) in [
            v.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: Constants.padding),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: Constants.padding)
            ]}
        
        view.add(subview: previewCell) { (v, p) in [
            v.topAnchor.constraint(equalTo: cvPreviewTitleLabel.bottomAnchor, constant: 5),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.2)
            ]}
        
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
        
        let titleLabel = BaseLabel(text: state.title, font: .regular, textColor: .Tint, numberOfLines: 1)
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
}

// MARK: - UICollectionView Delegate & DataSource Extension
/***************************************************************/
extension ChooseStateColorViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return all.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(ChooseStateColorCell.self, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cell as! ChooseStateColorCell
        
        cell.model = all[indexPath.row]
        
        if all[indexPath.row].color == state.color {
            cell.setAsSelected()
        } else {
            cell.setAsUnselected()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if UserDefaults.standard.bool(forKey: Constants.allInOne) || UserDefaults.standard.bool(forKey: Constants.customizeDesign) {
            switch state {
            case .Accepted:
                KeyManager.shared.acceptedColor = all[indexPath.row].color.toHexString()
            case .Applied:
                KeyManager.shared.appliedColor = all[indexPath.row].color.toHexString()
            case .Rejected:
                KeyManager.shared.rejectedColor = all[indexPath.row].color.toHexString()
            case .Interview:
                KeyManager.shared.interviewColor = all[indexPath.row].color.toHexString()
            default:
                break;
            }
            
            previewCell.injectPreviewData(state: state)
            collectionView.reloadData()
            
        } else {
            if indexPath.row != 0 {
                // Show Premium
                animatePremiumFeaturesView()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 2, height: collectionView.frame.size.height / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension ChooseStateColorViewController: UnlockPremiumFeaturesViewDelegate {
    
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
