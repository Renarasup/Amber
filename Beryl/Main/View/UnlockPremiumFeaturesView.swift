//
//  UnlockPremiumFeaturesView.swift
//  Beryl
//
//  Created by Giancarlo Buenaflor on 25.12.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class UnlockPremiumFeaturesView: UIView {
    
    private let imageView = UIImageView()
    private let titleLabel = BaseLabel(text: "Unlock Premium Features", font: .large, textColor: .Tint, numberOfLines: 1)
    private let descriptionLabel = BaseLabel(text: "Do you need more than 5 applications? Do you want to be able to customize the theme, and colors to your own liking?", font: .regular, textColor: .lightGray, numberOfLines: 0)
    private let actionLabel = UILabel()
    private let unlockButton = UIButton()
    
    private let onlyPackageTitle = BaseLabel(font: .regular, textColor: .Tint, numberOfLines: 1)
    private let onlyPackagePriceTitle = BaseLabel(font: .regular, textColor: .lightGray, numberOfLines: 1)
    
    private let viewPackageTitle = BaseLabel(text: "View Package", font: .regular, textColor: .Tint, numberOfLines: 1)
    
    private let restorePurchaseLabel = BaseLabel(text: "Restore Purchases", font: .regular, textColor: .lightGray, numberOfLines: 1)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "amberlogo")
        
        backgroundColor = .white
        
        layer.cornerRadius = Constants.bigCornerRadius
        
        titleLabel.textAlignment = .center
        descriptionLabel.textAlignment = .center
        actionLabel.textAlignment = .center

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
        
        setupViewsLayout()
    }
    
    func setupViewsLayout() {
        
        add(subview: imageView) { (v, p) in [
            v.topAnchor.constraint(equalTo: p.topAnchor, constant: Constants.padding + 5),
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
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.1),
            ]}
        
        add(subview: onlyPackageTitle) { (v, p) in [
            v.topAnchor.constraint(equalTo: unlockButton.bottomAnchor, constant: Constants.padding),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: Constants.padding)
            ]}
        
        add(subview: onlyPackagePriceTitle) { (v, p) in [
            v.topAnchor.constraint(equalTo: unlockButton.bottomAnchor, constant: Constants.padding),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor, constant: -Constants.padding)
            ]}
        
        add(subview: viewPackageTitle) { (v, p) in [
            v.topAnchor.constraint(equalTo: onlyPackageTitle.bottomAnchor, constant: Constants.padding),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: Constants.padding)
            ]}
        
        add(subview: restorePurchaseLabel) { (v, p) in [
            v.bottomAnchor.constraint(equalTo: p.bottomAnchor, constant: -Constants.padding),
            v.centerXAnchor.constraint(equalTo: p.centerXAnchor)
            ]}
    }
    
    func setPackage(_ package: Package) {
        unlockButton.setTitle("Unlock for €\(String(format: "%.2f", Package.allInOne.price))", for: .normal)
        onlyPackageTitle.text = "Only \(package.title)"
        onlyPackagePriceTitle.text = "€\(String(format: "%.2f", package.price))"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
