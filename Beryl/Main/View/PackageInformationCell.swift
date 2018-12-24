//
//  PackageInformationCell.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 24.12.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class PackageInformationCell: UICollectionViewCell {
    
    var model: Package.Information! {
        didSet {
            informationImageView.image = model.image
            titleLabel.text = model.title
            descriptionLabel.text = model.description
        }
    }
    
    private let separatorLineView = UIView()
    private let informationImageView = UIImageView()
    private let bottomContainerView = UIView()
    
    private let titleLabel = BaseLabel(font: .large, textColor: .Tint, numberOfLines: 1)
    private let descriptionLabel = BaseLabel(font: .regular, textColor: .lightGray, numberOfLines: 0)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .Main
        
        informationImageView.backgroundColor = .Main
        informationImageView.contentMode = .scaleAspectFill
        
        separatorLineView.backgroundColor = .lightGray
        
        bottomContainerView.backgroundColor = .Main
        
        descriptionLabel.textAlignment = .center

        fillToSuperview(informationImageView)
        
        informationImageView.add(subview: bottomContainerView) { (v, p) in [
            v.bottomAnchor.constraint(equalTo: p.bottomAnchor),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.25)
            ]}
        
        informationImageView.add(subview: separatorLineView) { (v, p) in [
            v.topAnchor.constraint(equalTo: bottomContainerView.topAnchor),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: Constants.padding*2),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor, constant: -Constants.padding*2),
            v.heightAnchor.constraint(equalToConstant: 0.5)
            ]}
        
        bottomContainerView.add(subview: titleLabel) { (v, p) in [
            v.topAnchor.constraint(equalTo: p.topAnchor, constant: Constants.padding),
            v.centerXAnchor.constraint(equalTo: p.centerXAnchor)
            ]}
        
        bottomContainerView.add(subview: descriptionLabel) { (v, p) in [
            v.bottomAnchor.constraint(equalTo: p.bottomAnchor, constant: -Constants.padding),
            v.centerXAnchor.constraint(equalTo: p.centerXAnchor),
            v.widthAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.72)
            ]}
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
