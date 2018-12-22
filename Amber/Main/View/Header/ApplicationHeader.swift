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
    private let cheatSheetLabel = BaseLabel(font: .regular, textColor: .white, numberOfLines: 1)

    private let paddingContainerView = UIView()
    private let filterView = HeaderBoxView()
    private let cheatSheetContainerView = HeaderBoxView()
    
    private let leftContainerView = UIView()
    private let rightContainerView = UIView()
    
    private let separatorLine = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        paddingContainerView.layer.cornerRadius = Constants.bigCornerRadius
        paddingContainerView.backgroundColor = UIColor.ApplicationHeader
        
        // Default Filter
        filterView.layer.cornerRadius = Constants.bigCornerRadius
        filterView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onFilterTap)))
        
        // Default Cheat Sheet
        cheatSheetContainerView.layer.cornerRadius = Constants.bigCornerRadius
        cheatSheetContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onFilterTap)))
        cheatSheetContainerView.setValues(color: UIColor.CheatSheetBox, image: #imageLiteral(resourceName: "sheets"), text: "Cheat Sheet", subText: "None available")
        
        separatorLine.backgroundColor = .lightGray
        
        setupViewsLayout()
    }
    
    private func setupViewsLayout() {
        
        add(subview: paddingContainerView) { (v, p) in [
            v.topAnchor.constraint(equalTo: p.topAnchor, constant: Constants.padding + 10),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: Constants.padding),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor, constant: -Constants.padding),
            v.bottomAnchor.constraint(equalTo: p.bottomAnchor, constant: -Constants.padding - 10)
            ]}
        
        // Adding Left Container
        paddingContainerView.add(subview: leftContainerView) { (v, p) in [
            v.topAnchor.constraint(equalTo: p.topAnchor),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor),
            v.widthAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.5),
            v.bottomAnchor.constraint(equalTo: p.bottomAnchor)
            ]}
        
        // Adding Right Container
        paddingContainerView.add(subview: rightContainerView) { (v, p) in [
            v.topAnchor.constraint(equalTo: p.topAnchor),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor),
            v.widthAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.5),
            v.bottomAnchor.constraint(equalTo: p.bottomAnchor)
            ]}
        
        // Adding Filter
        leftContainerView.add(subview: filterView) { (v, p) in [
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.75),
            v.centerYAnchor.constraint(equalTo: p.centerYAnchor),
            v.widthAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.75),
            v.centerXAnchor.constraint(equalTo: p.centerXAnchor)
            ]}
        
        
        // Adding CheatSheet
        rightContainerView.add(subview: cheatSheetContainerView) { (v, p) in [
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.75),
            v.centerYAnchor.constraint(equalTo: p.centerYAnchor),
            v.widthAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.75),
            v.centerXAnchor.constraint(equalTo: p.centerXAnchor)
            ]}
        
        cheatSheetContainerView.add(subview: cheatSheetLabel) { (v, p) in [
            v.centerXAnchor.constraint(equalTo: p.centerXAnchor),
            v.centerYAnchor.constraint(equalTo: p.centerYAnchor)
            ]}
        
        // Adding Separator Line at the bottom
        add(subview: separatorLine) { (v, p) in [
            v.bottomAnchor.constraint(equalTo: p.bottomAnchor),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: Constants.padding),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor, constant: -Constants.padding),
            v.heightAnchor.constraint(equalToConstant: 0.5)
            ]}
    }
    
    @objc private func onFilterTap() {
        delegate?.didClick(self)
    }
    
    // Set Filter State and change Styling accordingly - called from ApplicationViewController
    func setState(_ state: Application.StateType, filteredNumOfApplications: Int, totalNumOfApplications: Int) {
        filterView.setValues(color: state.color, image: #imageLiteral(resourceName: "filter"), text: state.title, subText: "\(filteredNumOfApplications)/\(totalNumOfApplications)")
        filterView.addProgressBar(percentage: CGFloat(Double(filteredNumOfApplications) / Double(totalNumOfApplications)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
