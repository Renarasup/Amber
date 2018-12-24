//
//  SearchApplicationCell.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 03.11.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit
import Kingfisher

class SearchApplicationCell: UITableViewCell {
    
    var model: SearchApplication! {
        didSet {
            logoImageView.kf.setImage(with: URL(string: model.logoPath)!)
            nameLabel.text = model.name
            domainLabel.text = model.domain
        }
    }
    
    private let containerView = UIView()
    private let logoImageView = UIImageView()
    private let nameLabel = BaseLabel(font: .regular, textColor: .Tint, numberOfLines: 1)
    private let domainLabel = BaseLabel(font: .medium, textColor: .Placeholder, numberOfLines: 1)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        logoImageView.contentMode = .scaleAspectFit
        containerView.layer.borderColor = UIColor.Tint.cgColor
        containerView.layer.borderWidth = 0.5
        containerView.layer.cornerRadius = 5
        
        domainLabel.textAlignment = .right
        nameLabel.textAlignment = .left
        
        setupViewLayout()
    }
    
    private func setupViewLayout() {
        
        add(subview: containerView) { (v, p) in [
            v.centerYAnchor.constraint(equalTo: p.centerYAnchor),
            v.centerXAnchor.constraint(equalTo: p.centerXAnchor),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.8),
            v.widthAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.9)
            ]}
        
        containerView.add(subview: logoImageView) { (v, p) in [
            v.centerYAnchor.constraint(equalTo: p.centerYAnchor),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor, constant: -10),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.6),
            v.widthAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.6)
            ]}
        
        containerView.add(subview: domainLabel) { (v, p) in [
            v.centerYAnchor.constraint(equalTo: p.centerYAnchor),
            v.trailingAnchor.constraint(equalTo: logoImageView.leadingAnchor, constant: -10)
            ]}
        
        containerView.add(subview: nameLabel) { (v, p) in [
            v.centerYAnchor.constraint(equalTo: p.centerYAnchor),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: 10),
            v.trailingAnchor.constraint(equalTo: domainLabel.leadingAnchor, constant: -10)
            ]}
    }
    
    func getLogoImage() -> UIImage {
        if let image = logoImageView.image {
            return image
        } else {
            return UIImage()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
