//
//  InformationCell.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 03.11.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class InformationCell: UICollectionViewCell {
    
    var model: Application.Information! {
        didSet {
            textField.placeholder = model.title
        }
    }
    
    let textField = UITextField()
    
    private let separatorLine = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        separatorLine.backgroundColor = .darkGray
        textField.backgroundColor = .clear
        
        setupViewLayout()
    }
    
    private func setupViewLayout() {
        add(subview: separatorLine) { (v, p) in [
            v.bottomAnchor.constraint(equalTo: p.bottomAnchor, constant: -10),
            v.centerXAnchor.constraint(equalTo: p.centerXAnchor),
            v.widthAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.85),
            v.heightAnchor.constraint(equalToConstant: 0.6)
            ]}
        
        add(subview: textField) { (v, p) in [
            v.bottomAnchor.constraint(equalTo: separatorLine.topAnchor, constant: -5),
            v.leadingAnchor.constraint(equalTo: separatorLine.leadingAnchor),
            v.widthAnchor.constraint(equalTo: separatorLine.widthAnchor, multiplier: 0.7),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.3)
            ]}
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
