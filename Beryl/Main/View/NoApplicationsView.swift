//
//  NoApplicationsView.swift
//  Beryl
//
//  Created by Giancarlo Buenaflor on 25.12.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class NoApplicationsView: UIView {
    
    private let imageView = UIImageView()
    private let titleLabel = BaseLabel(text: "Add your first Application!", font: .large, textColor: .Tint, numberOfLines: 1)
    private let descriptionLabel = BaseLabel(text: "Tap the + to easily manage and track your applications. Don't forget that you can add notes to your applications!", font: .regular, textColor: .lightGray, numberOfLines: 0)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .Main
        
        
        imageView.image = #imageLiteral(resourceName: "symbol").withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        
        descriptionLabel.textAlignment = .center
        
        setupViewsLayout()
    }
    
    private func setupViewsLayout() {
        
        add(subview: titleLabel) { (v, p) in [
            v.centerXAnchor.constraint(equalTo: p.centerXAnchor),
            v.centerYAnchor.constraint(equalTo: p.centerYAnchor)
            ]}

        add(subview: imageView) { (v, p) in [
            v.centerXAnchor.constraint(equalTo: p.centerXAnchor),
            v.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -Constants.padding),
            v.widthAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.22),
            v.heightAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.22)
            ]}
        
        add(subview: descriptionLabel) { (v, p) in [
            v.centerXAnchor.constraint(equalTo: p.centerXAnchor),
            v.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.padding),
            v.widthAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.7)
            ]}
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
