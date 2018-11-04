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
    
    private let circleView = UIView()
    private let lineBottomView = UIView()
    private let lineTopView = UIView()
    private let logoImageView = UIImageView()
    private let separatorLine = UIView()
    
    private let circleHeight: CGFloat = UIScreen.main.bounds.width * 0.05
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        separatorLine.backgroundColor = .darkGray
        textField.backgroundColor = .clear
        
        circleView.backgroundColor = .blue
        lineBottomView.backgroundColor = .blue
        lineTopView.backgroundColor = .blue
        
        setupViewLayout()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        circleView.layer.cornerRadius = circleView.frame.size.width / 2
    }
    
    private func setupViewLayout() {

        add(subview: circleView) { (v, p) in [
            v.bottomAnchor.constraint(equalTo: p.bottomAnchor, constant: -12),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: 30),
            v.heightAnchor.constraint(equalToConstant: circleHeight),
            v.widthAnchor.constraint(equalToConstant: circleHeight)
            ]}
        
        add(subview: separatorLine) { (v, p) in [
            v.bottomAnchor.constraint(equalTo: p.bottomAnchor, constant: -10),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor, constant: -30),
            v.leadingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: 30),
            v.heightAnchor.constraint(equalToConstant: 0.3)
            ]}

        add(subview: textField) { (v, p) in [
            v.bottomAnchor.constraint(equalTo: separatorLine.topAnchor, constant: -5),
            v.leadingAnchor.constraint(equalTo: separatorLine.leadingAnchor),
            v.widthAnchor.constraint(equalTo: separatorLine.widthAnchor, multiplier: 0.8),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.3)
            ]}
    }
    
    func addLineToTop() {
        add(subview: lineBottomView) { (v, p) in [
            v.bottomAnchor.constraint(equalTo: circleView.centerYAnchor),
            v.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            v.widthAnchor.constraint(equalToConstant: 3),
            v.topAnchor.constraint(equalTo: p.topAnchor)
            ]}
    }
    
    func addLineToBottom() {
        add(subview: lineTopView) { (v, p) in [
            v.topAnchor.constraint(equalTo: circleView.centerYAnchor),
            v.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            v.widthAnchor.constraint(equalToConstant: 3),
            v.bottomAnchor.constraint(equalTo: p.bottomAnchor)
            ]}
    }

    func addLogoImage(_ image: UIImage) {
        add(subview: logoImageView) { (v, p) in [
            v.bottomAnchor.constraint(equalTo: separatorLine.topAnchor, constant: -5),
            v.trailingAnchor.constraint(equalTo: separatorLine.trailingAnchor),
            v.widthAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.28),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.28)
            ]}
        
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.image = image
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
