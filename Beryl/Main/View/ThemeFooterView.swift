//
//  ThemeFooterView.swift
//  Beryl
//
//  Created by Giancarlo Buenaflor on 25.12.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class ThemeFooterView: UIView {
    
    private let titleLabel = BaseLabel(text: "PREVIEW", font: UIFont.regular.withSize(13), textColor: .TableViewHeader, numberOfLines: 1)
    private let themeImageView = UIImageView()
    
    private let containerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .Secondary
        
        if UIColor.Main == .white {
            themeImageView.image = #imageLiteral(resourceName: "darkTheme")
        } else {
            themeImageView.image = #imageLiteral(resourceName: "lightTheme")
        }
        
        themeImageView.contentMode = .scaleAspectFit
        
        setupViewsLayout()
    }
    
    private func setupViewsLayout() {
        
        add(subview: titleLabel) { (v, p) in [
            v.topAnchor.constraint(equalTo: p.safeAreaLayoutGuide.topAnchor, constant: Constants.padding),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: Constants.padding)
            ]}
        
        add(subview: themeImageView) { (v, p) in [
            v.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.padding),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: Constants.padding),
            v.widthAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.9),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.45)
            ]}
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
