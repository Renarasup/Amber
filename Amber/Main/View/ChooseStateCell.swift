//
//  ChooseStateCell.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 08.11.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class ChooseStateCell: UITableViewCell {
    
    var model: Application.StateType! {
        didSet {
            containerView.backgroundColor = model.color
            titleLabel.text = model.title
        }
    }
    
    private let containerView = UIView()
    private let titleLabel = BaseLabel(font: .regular, textColor: .white, numberOfLines: 1)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        
        titleLabel.textColor = .white
        containerView.layer.cornerRadius = 7
        
        setupViewLayout()
    }
    
    private func setupViewLayout() {
        add(subview: containerView) { (v, p) in [
            v.centerXAnchor.constraint(equalTo: p.centerXAnchor),
            v.centerYAnchor.constraint(equalTo: p.centerYAnchor),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.7),
            v.widthAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.7)
            ]}
        
        containerView.add(subview: titleLabel) { (v, p) in [
            v.centerXAnchor.constraint(equalTo: p.centerXAnchor),
            v.centerYAnchor.constraint(equalTo: p.centerYAnchor)
            ]}
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
