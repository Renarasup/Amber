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
        }
    }
    
    private let logoImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        logoImageView.contentMode = .scaleAspectFit
        
        setupViewLayout()
    }
    
    private func setupViewLayout() {
        add(subview: logoImageView) { (v, p) in [
            v.centerYAnchor.constraint(equalTo: p.centerYAnchor),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor, constant: -10),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.5),
            v.widthAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.5)
            ]}
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
