//
//  FooterView.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 24.12.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class FooterView: UIView {
    
    private let logoImageView = UIImageView()
    private let titleLabel = BaseLabel(text: Constants.appVersion, font: .medium, textColor: .lightGray, numberOfLines: 1)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.image = #imageLiteral(resourceName: "amberlogo")
        
        titleLabel.textAlignment = .center
        
        backgroundColor = .clear
        
        let sv = UIStackView(arrangedSubviews: [logoImageView, titleLabel])
        sv.axis = .vertical
        sv.distribution = .fillEqually
        
        add(subview: sv) { (v, p) in [
            v.topAnchor.constraint(equalTo: p.topAnchor),
            v.centerXAnchor.constraint(equalTo: p.centerXAnchor),
            v.widthAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.6),
            v.bottomAnchor.constraint(equalTo: p.bottomAnchor)
            ]}
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
