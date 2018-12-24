//
//  CustomSearchBarView.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 22.12.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class CustomSearchBarView: UIView {
    
    private let textField = UITextField()
    private let containerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        containerView.backgroundColor = .lightGray
        
        setupViewsLayout()
    }
    
    private func setupViewsLayout() {
        add(subview: containerView) { (v, p) in [
            v.topAnchor.constraint(equalTo: p.topAnchor, constant: 5),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: 5),
            v.widthAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.8),
            v.bottomAnchor.constraint(equalTo: p.bottomAnchor, constant: -5)
            ]}
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
