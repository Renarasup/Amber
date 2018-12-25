//
//  PackageCell.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 24.12.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit
import StoreKit

protocol PackageCellDelegate: class {
    func didView(package: Package)
    func didBuy(package: Package, product: SKProduct)
}

class PackageCell: UITableViewCell {

    weak var delegate: PackageCellDelegate?
    
    var package: Package?
    
    var model: SKProduct! {
        didSet {
            
            if UserDefaults.standard.bool(forKey: Constants.allInOne) {
                buyPackButton.isEnabled = false
                buyPackButton.setTitle("Unlocked", for: .normal)
//                buyPackButton.backgroundColor = UIColor.PackagesButtons.withAlphaComponent(0.3)
                buyPackButton.backgroundColor = UIColor.lightGray
            } else if model.productIdentifier == Constants.customizeDesign || model.productIdentifier == Constants.unlimitedApplications {
                let purchased = UserDefaults.standard.bool(forKey: model.productIdentifier)

                if purchased {
                    buyPackButton.isEnabled = false
                    buyPackButton.setTitle("Unlocked", for: .normal)
                    buyPackButton.backgroundColor = UIColor.lightGray
                } else {
                    if IAPHelper.canMakePayments() {
                        buyPackButton.setTitle("Unlock €\(model.price)".replacingOccurrences(of: ".", with: ","), for: .normal)
                    } else {
                        buyPackButton.setTitle("Not Available", for: .normal)
                    }
                }
            } else {
                if IAPHelper.canMakePayments() {
                    buyPackButton.setTitle("Unlock €\(model.price)".replacingOccurrences(of: ".", with: ","), for: .normal)
                } else {
                    buyPackButton.setTitle("Not Available", for: .normal)
                }
            }
            
            let package = Package.get(model.productIdentifier)
            self.package = package
            
            packageImageView.image = package.image
            titleLabel.text = package.title
            descriptionLabel.text = package.description
            
            if package == .allInOne {
                let mutableString = NSMutableAttributedString()
                
                let attributedString: NSMutableAttributedString =  NSMutableAttributedString(string: "€2,19")
                attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedString.length))
                
                let discountAttributedString = NSAttributedString.String("   50% Discount", font: .bold, color: UIColor(rgb: 0xcd6133))
                
                mutableString.append(attributedString)
                mutableString.append(discountAttributedString)
                
                strikedThroughLabel.attributedText = mutableString
                descriptionLabel.text = package.description
                
                add(subview: strikedThroughLabel) { (v, p) in [
                    v.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Constants.padding),
                    v.centerXAnchor.constraint(equalTo: p.centerXAnchor)
                    ]}
            }
        }
    }
    
    private let viewPackButton = UIButton()
    private let buyPackButton = UIButton()
    
    private let packageImageView = UIImageView()
    private let titleLabel = BaseLabel(font: .large, textColor: .Tint, numberOfLines: 1)
    private let strikedThroughLabel = BaseLabel(font: .bold, textColor: .lightGray, numberOfLines: 0)
    private let descriptionLabel = BaseLabel(font: .regular, textColor: .lightGray, numberOfLines: 0)
    private let containerView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .Main
        containerView.backgroundColor = .Main
        
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.layer.borderWidth = 0.5
        containerView.layer.cornerRadius = Constants.bigCornerRadius
        
        viewPackButton.layer.cornerRadius = Constants.smallCornerRadius
        buyPackButton.layer.cornerRadius = Constants.smallCornerRadius
        
        viewPackButton.backgroundColor = UIColor.PackagesButtons.withAlphaComponent(0.3)
        buyPackButton.backgroundColor = .PackagesButtons
        
        viewPackButton.setTitleColor(UIColor.PackagesButtons.withAlphaComponent(0.9), for: .normal)

        descriptionLabel.textAlignment = .center
        
        viewPackButton.setTitle("View Package", for: .normal)
        
        viewPackButton.titleLabel?.font = .regular
        buyPackButton.titleLabel?.font = .regular

        packageImageView.contentMode = .scaleAspectFill

        viewPackButton.addTarget(self, action: #selector(onViewPackPressed), for: .touchUpInside)
        buyPackButton.addTarget(self, action: #selector(onBuyPackPressed), for: .touchUpInside)

        add(subview: containerView) { (v, p) in [
            v.topAnchor.constraint(equalTo: p.topAnchor, constant: Constants.padding),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: Constants.padding),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor, constant: -Constants.padding),
            v.bottomAnchor.constraint(equalTo: p.bottomAnchor, constant: -Constants.padding)
            ]}
        
        containerView.add(subview: packageImageView) { (v, p) in [
            v.topAnchor.constraint(equalTo: p.topAnchor, constant: Constants.padding * 2),
            v.widthAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.14),
            v.heightAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.14),
            v.centerXAnchor.constraint(equalTo: p.centerXAnchor)
            ]}
        
        add(subview: titleLabel) { (v, p) in [
            v.topAnchor.constraint(equalTo: packageImageView.bottomAnchor, constant: Constants.padding),
            v.centerXAnchor.constraint(equalTo: p.centerXAnchor)
            ]}
        
        add(subview: descriptionLabel) { (v, p) in [
            v.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.padding),
            v.widthAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.65),
            v.centerXAnchor.constraint(equalTo: p.centerXAnchor)
            ]}
        
        add(subview: strikedThroughLabel) { (v, p) in [
            v.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Constants.padding),
            v.centerXAnchor.constraint(equalTo: p.centerXAnchor)
            ]}
        
        let sv = UIStackView(arrangedSubviews: [viewPackButton, buyPackButton])
        sv.distribution = .fillEqually
        sv.spacing = Constants.padding

        containerView.add(subview: sv) { (v, p) in [
            v.bottomAnchor.constraint(equalTo: p.bottomAnchor, constant: -Constants.padding),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor, constant: -Constants.padding),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.15),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: Constants.padding)
            ]}
    }
    
    @objc private func onViewPackPressed() {
        guard let package = package else {
            return
        }
        delegate?.didView(package: package)
    }
    
    @objc private func onBuyPackPressed() {
        guard let package = package else {
            return
        }
        delegate?.didBuy(package: package, product: model)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
