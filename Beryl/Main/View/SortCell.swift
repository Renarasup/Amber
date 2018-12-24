//
//  SortCell.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 22.12.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class SortCell: UITableViewCell {
    
    var model: Application.StateType! {
        didSet {
            titleLabel.text = model.title
        }
    }
    
    private let circleContainerView = UIView()
    private let checkImageView = UIImageView()
    
    let titleLabel = BaseLabel(font: .regular, textColor: .Tint, numberOfLines: 1)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        circleContainerView.backgroundColor = .lightGray
        checkImageView.image = #imageLiteral(resourceName: "checkmark").withRenderingMode(.alwaysTemplate)
        checkImageView.tintColor = .white
        checkImageView.alpha = 0
        
        setupViewsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        circleContainerView.layer.cornerRadius = circleContainerView.frame.height / 2
        circleContainerView.clipsToBounds = true
    }
    
    private func setupViewsLayout() {
        add(subview: titleLabel) { (v, p) in [
            v.centerYAnchor.constraint(equalTo: p.centerYAnchor),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: Constants.padding)
            ]}
        
        add(subview: circleContainerView) { (v, p) in [
            v.centerYAnchor.constraint(equalTo: p.centerYAnchor),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor, constant: -Constants.padding),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.6),
            v.widthAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.6)
            ]}
        
        circleContainerView.add(subview: checkImageView) { (v, p) in [
            v.centerYAnchor.constraint(equalTo: p.centerYAnchor),
            v.centerXAnchor.constraint(equalTo: p.centerXAnchor),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.6),
            v.widthAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.6)
            ]}
    }
    
    func setAsSelected() {
        UIView.animate(withDuration: 0.25) {
            self.circleContainerView.backgroundColor = self.model.color
            self.checkImageView.alpha = 1
        }
    }
    
    func resetSelection() {
        circleContainerView.backgroundColor = .lightGray
        checkImageView.alpha = 0
    }
    
    func addSeparatorLine() {
//        let separatorLine = UIView()
//        separatorLine.backgroundColor = .Tint
//        
//        add(subview: separatorLine) { (v, p) in [
//            v.bottomAnchor.constraint(equalTo: p.bottomAnchor),
//            v.leadingAnchor.constraint(equalTo: p.leadingAnchor),
//            v.trailingAnchor.constraint(equalTo: p.trailingAnchor),
//            v.heightAnchor.constraint(equalToConstant: 0.5)
//            ]}
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
