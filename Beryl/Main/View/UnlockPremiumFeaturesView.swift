//
//  UnlockPremiumFeaturesView.swift
//  Beryl
//
//  Created by Giancarlo Buenaflor on 25.12.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

protocol UnlockPremiumFeaturesViewDelegate: class {
    func dismiss()
    func didPressBuyAllInOne()
    func didPressViewAllInOnePackage()
    func didPressBuy(package: Package)
    func didRestorePurchase()
}

class UnlockPremiumFeaturesView: UIView {
    
    weak var delegate: UnlockPremiumFeaturesViewDelegate?
    
    private var package: Package?
    
    private let crossmarkButton = UIButton()

    private let imageView = UIImageView()
    private let titleLabel = BaseLabel(text: "Unlock Premium Features", font: .large, textColor: .Tint, numberOfLines: 1)
    private let descriptionLabel = BaseLabel(text: "Do you need more than 5 applications? Do you want to be able to customize the theme, and colors to your own liking?", font: .regular, textColor: .lightGray, numberOfLines: 0)
    private let actionLabel = UILabel()
    private let unlockButton = UIButton()
    
    private let onlyPackageTitle = BaseLabel(font: .regular, textColor: .Tint, numberOfLines: 1)
    private let onlyPackagePriceTitle = BaseLabel(font: .regular, textColor: .lightGray, numberOfLines: 1)
    
    private let viewPackageTitle = BaseLabel(text: "View Package", font: .regular, textColor: .Tint, numberOfLines: 1)
    private let arrowImageView = UIImageView()

    private let restorePurchaseButton = UIButton()
    
    private let topContainerView = UIView()
    private let middleContainerView = UIView()
    private let bottomContainerView = UIView()

    private let wholeBottomContainerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "amberlogo")
        
        crossmarkButton.setImage(#imageLiteral(resourceName: "crossmark").withRenderingMode(.alwaysTemplate), for: .normal)
        crossmarkButton.tintColor = .lightGray

        arrowImageView.image = #imageLiteral(resourceName: "arrow-right").withRenderingMode(.alwaysTemplate)
        arrowImageView.tintColor = .lightGray
        
        backgroundColor = .white
        
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = Constants.bigCornerRadius
        
        titleLabel.textAlignment = .center
        descriptionLabel.textAlignment = .center
        actionLabel.textAlignment = .center
        
        restorePurchaseButton.setTitle("Restore Purchase", for: .normal)
        restorePurchaseButton.titleLabel?.font = .regular
        restorePurchaseButton.setTitleColor(.lightGray, for: .normal)
        
        unlockButton.layer.cornerRadius = Constants.smallCornerRadius
        unlockButton.backgroundColor = .PackagesButtons
        unlockButton.titleLabel?.font = .regular
        
        let saveAttributedString =  NSAttributedString.String("Save", font: .regular, color: .lightGray)
        let discountAttributedString = NSAttributedString.String(" 50% ", font: .large, color: UIColor(rgb: 0xcd6133))
        let unlockAttributedString =  NSAttributedString.String("and unlock the All In One Package!", font: .regular, color: .lightGray)
        
        let mutableString = NSMutableAttributedString(attributedString: saveAttributedString)
        mutableString.append(discountAttributedString)
        mutableString.append(unlockAttributedString)
        
        actionLabel.attributedText = mutableString
        actionLabel.numberOfLines = 0
        
        unlockButton.addTarget(self, action: #selector(onBuyAllInOnePressed), for: .touchUpInside)
        restorePurchaseButton.addTarget(self, action: #selector(onRestorePurchasesPressed), for: .touchUpInside)
        topContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onBuySinglePackagePressed)))
        middleContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onViewAllPackagesPressed)))
        crossmarkButton.addTarget(self, action: #selector(onDismissPressed), for: .touchUpInside)
        
        setupViewsLayout()
    }
    
    func setupViewsLayout() {
        
        add(subview: crossmarkButton) { (v, p) in [
            v.topAnchor.constraint(equalTo: p.topAnchor, constant: Constants.padding),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: Constants.padding),
            v.heightAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.08),
            v.widthAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.08)
            ]}
        
        add(subview: imageView) { (v, p) in [
            v.topAnchor.constraint(equalTo: crossmarkButton.bottomAnchor, constant: Constants.padding),
            v.centerXAnchor.constraint(equalTo: p.centerXAnchor),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.1),
            v.widthAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.4)
            ]}
        
        add(subview: titleLabel) { (v, p) in [
            v.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.padding),
            v.centerXAnchor.constraint(equalTo: p.centerXAnchor)
            ]}
        
        add(subview: descriptionLabel) { (v, p) in [
            v.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.padding),
            v.centerXAnchor.constraint(equalTo: p.centerXAnchor),
            v.widthAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.8)
            ]}
        
        add(subview: actionLabel) { (v, p) in [
            v.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Constants.padding),
            v.widthAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.8),
            v.centerXAnchor.constraint(equalTo: p.centerXAnchor)
            ]}
        
        add(subview: unlockButton) { (v, p) in [
            v.topAnchor.constraint(equalTo: actionLabel.bottomAnchor, constant: Constants.padding),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: Constants.padding),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor, constant: -Constants.padding),
            v.heightAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.12),
            ]}
        
        add(subview: wholeBottomContainerView) { (v, p) in [
            v.topAnchor.constraint(equalTo: unlockButton.bottomAnchor, constant: Constants.padding),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor),
            v.bottomAnchor.constraint(equalTo: p.bottomAnchor),
            ]}
        
        wholeBottomContainerView.add(subview: topContainerView) { (v, p) in [
            v.topAnchor.constraint(equalTo: p.topAnchor),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.33),
            ]}
        
        wholeBottomContainerView.add(subview: middleContainerView) { (v, p) in [
            v.topAnchor.constraint(equalTo: topContainerView.bottomAnchor),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.33),
            ]}
        
        wholeBottomContainerView.add(subview: bottomContainerView) { (v, p) in [
            v.topAnchor.constraint(equalTo: middleContainerView.bottomAnchor),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor),
            v.bottomAnchor.constraint(equalTo: p.bottomAnchor),
            ]}
        
        topContainerView.add(subview: onlyPackageTitle) { (v, p) in [
            v.centerYAnchor.constraint(equalTo: p.centerYAnchor),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: Constants.padding)
            ]}
        
        topContainerView.add(subview: onlyPackagePriceTitle) { (v, p) in [
            v.centerYAnchor.constraint(equalTo: p.centerYAnchor),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor, constant: -Constants.padding)
            ]}
        
        middleContainerView.add(subview: viewPackageTitle) { (v, p) in [
            v.centerYAnchor.constraint(equalTo: p.centerYAnchor),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: Constants.padding)
            ]}
        
        middleContainerView.add(subview: arrowImageView) { (v, p) in [
            v.centerYAnchor.constraint(equalTo: p.centerYAnchor),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor, constant: -Constants.padding),
            v.heightAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.07),
            v.widthAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.07)
            ]}
        
        bottomContainerView.add(subview: restorePurchaseButton) { (v, p) in [
            v.centerYAnchor.constraint(equalTo: p.centerYAnchor),
            v.centerXAnchor.constraint(equalTo: p.centerXAnchor),
            v.widthAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.7),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.6)
            ]}
        
        let sepView = UIView()
        sepView.backgroundColor = .lightGray
        let sepView2 = UIView()
        sepView2.backgroundColor = .lightGray
        let sepView3 = UIView()
        sepView3.backgroundColor = .lightGray

        add(subview: sepView) { (v, p) in [
            v.bottomAnchor.constraint(equalTo: middleContainerView.bottomAnchor),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor),
            v.heightAnchor.constraint(equalToConstant: 0.3)
            ]}
        
        add(subview: sepView2) { (v, p) in [
            v.bottomAnchor.constraint(equalTo: topContainerView.bottomAnchor),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor),
            v.heightAnchor.constraint(equalToConstant: 0.3)
            ]}

        add(subview: sepView3) { (v, p) in [
            v.topAnchor.constraint(equalTo: unlockButton.bottomAnchor, constant: Constants.padding),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor),
            v.heightAnchor.constraint(equalToConstant: 0.3)
            ]}
    }
    
    @objc private func onDismissPressed() {
        delegate?.dismiss()
    }
    
    @objc private func onBuyAllInOnePressed() {
        delegate?.didPressBuy(package: .allInOne)
    }
    
    @objc private func onRestorePurchasesPressed() {
        delegate?.didRestorePurchase()
    }
    
    @objc private func onBuySinglePackagePressed() {
        if let package = package {
            delegate?.didPressBuy(package: package)
        }
    }
    
    @objc private func onViewAllPackagesPressed() {
        delegate?.didPressViewAllInOnePackage()
    }
    
    func setPackage(_ package: Package) {
        unlockButton.setTitle("Unlock for €\(String(format: "%.2f", Package.allInOne.price))", for: .normal)
        onlyPackageTitle.text = "Only buy \(package.title)"
        onlyPackagePriceTitle.text = "€\(String(format: "%.2f", package.price))"
        
        self.package = package
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
