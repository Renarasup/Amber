//
//  ApplicationHeader.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 19.12.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

protocol ApplicationHeaderDelegate: class {
    func didClick(_ header: ApplicationHeader)
}

class ApplicationHeader: UIView {
    
    weak var delegate: ApplicationHeaderDelegate?
    
    private let filterLabel = BaseLabel(font: .regular, textColor: .white, numberOfLines: 1)
    
    private let containerView = UIView()
    private let filterContainerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        filterContainerView.layer.cornerRadius = 10
        filterContainerView.backgroundColor = Application.StateType.Applied.color
        filterContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onFilterTap)))
        
        filterLabel.text = Application.StateType.Applied.title
        
    
        
        setupViewsLayout()
    }
    
    private func setupViewsLayout() {
        add(subview: containerView) { (v, p) in [
            v.topAnchor.constraint(equalTo: p.topAnchor, constant: 10),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: 30),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor, constant: -30),
            v.bottomAnchor.constraint(equalTo: p.bottomAnchor, constant: -10)
            ]}
        
        containerView.add(subview: filterContainerView) { (v, p) in [
            v.topAnchor.constraint(equalTo: p.topAnchor),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor),
            v.widthAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.45),
            v.bottomAnchor.constraint(equalTo: p.bottomAnchor)
            ]}
        
        filterContainerView.add(subview: filterLabel) { (v, p) in [
            v.centerXAnchor.constraint(equalTo: p.centerXAnchor),
            v.centerYAnchor.constraint(equalTo: p.centerYAnchor)
            ]}
    }
    
    @objc private func onFilterTap() {
        delegate?.didClick(self)
    }
    
    func setState(_ state: Application.StateType) {
        filterContainerView.backgroundColor = state.color
        filterLabel.text = state.title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
