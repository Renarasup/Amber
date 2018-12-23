//
//  ChooseStateColorCell.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 23.12.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class ChooseStateColorCell: UICollectionViewCell {
    
    var model: ChooseStateColor! {
        didSet {
            containerView.backgroundColor = model.color
            titleLabel.text = model.title
        }
    }
    
    private let titleLabel = BaseLabel(font: .regular, textColor: .white, numberOfLines: 1)
    private let containerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        containerView.layer.cornerRadius = Constants.bigCornerRadius
        
        add(subview: containerView) { (v, p) in [
            v.topAnchor.constraint(equalTo: p.topAnchor, constant: Constants.padding),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: Constants.padding),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor, constant: -Constants.padding),
            v.bottomAnchor.constraint(equalTo: p.bottomAnchor, constant: -Constants.padding)
            ]}
        
        containerView.add(subview: titleLabel) { (v, p) in [
            v.centerXAnchor.constraint(equalTo: p.centerXAnchor),
            v.centerYAnchor.constraint(equalTo: p.centerYAnchor)
            ]}
    }
    
    func setAsSelected() {
        containerView.layer.borderColor = UIColor.Tint.cgColor
        containerView.layer.borderWidth = 3
    }
    
    func setAsUnselected() {
        containerView.layer.borderColor = UIColor.clear.cgColor
        containerView.layer.borderWidth = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
