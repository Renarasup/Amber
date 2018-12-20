//
//  FilterView.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 20.12.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class HeaderBoxView: UIView {
    
    private let topContainerView = UIView()
    private let bottomContainerView = UIView()
    
    private let imageView = UIImageView()
    private let titleLabel = BaseLabel(font: .regular, textColor: .black, numberOfLines: 1)
    private let subTitleLabel = BaseLabel(font: .medium, textColor: .lightGray, numberOfLines: 1)
    
    // Don't let the name confuse you, it just looks like one
    private let progressBar = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        topContainerView.layer.cornerRadius = Constants.bigCornerRadius
        topContainerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 1
        layer.shadowRadius = 4.0
        layer.shadowColor = UIColor.init(rgb: 0x9C9C9C).cgColor
        
        imageView.tintColor = .white

        setupViewsLayout()
    }
    
    private func setupViewsLayout() {
        
        // Add Top Container
        add(subview: topContainerView) { (v, p) in [
            v.topAnchor.constraint(equalTo: p.topAnchor),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.5)
            ]}
        
        // Add Bottom Container
        add(subview: bottomContainerView) { (v, p) in [
            v.bottomAnchor.constraint(equalTo: p.bottomAnchor),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.5)
            ]}
        
        // Add ImageView
        topContainerView.add(subview: imageView) { (v, p) in [
            v.centerXAnchor.constraint(equalTo: p.centerXAnchor),
            v.centerYAnchor.constraint(equalTo: p.centerYAnchor),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.45),
            v.widthAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.45)
            ]}
        
        // Add Title Label
        bottomContainerView.add(subview: titleLabel) { (v, p) in [
            v.topAnchor.constraint(equalTo: p.topAnchor, constant: Constants.padding - 5),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: Constants.padding - 5)
            ]}
        
        // Add Subtitle Label
        bottomContainerView.add(subview: subTitleLabel) { (v, p) in [
            v.bottomAnchor.constraint(equalTo: p.bottomAnchor, constant: -Constants.padding + 5),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: Constants.padding - 5)
            ]}
    }
    
    func addProgressBar(percentage: CGFloat) {
        layoutIfNeeded()
        print(intrinsicContentSize.width)
        print(bottomContainerView.intrinsicContentSize.width)
        
        bottomContainerView.add(subview: progressBar) { (v, p) in [
            v.bottomAnchor.constraint(equalTo: p.bottomAnchor),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: Constants.padding - 5),
            v.heightAnchor.constraint(equalToConstant: 2),
            v.widthAnchor.constraint(equalToConstant: (frame.width * percentage) - 5)
            ]}
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setValues(color: UIColor, image: UIImage, text: String, subText: String) {
        topContainerView.backgroundColor = color
        progressBar.backgroundColor = color
        imageView.image = image.withRenderingMode(.alwaysTemplate)
        titleLabel.text = text
        subTitleLabel.text = subText
    }
}
