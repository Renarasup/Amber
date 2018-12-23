//
//  SortView.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 21.12.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

protocol SortViewDelegate: class {
    func didChooseState(_ sortView: SortView, state: Application.StateType)
}

class SortView: UIView {
    
    weak var delegate: SortViewDelegate?
    
    private var selectedIndex = Application.StateType.All.rawValue;
    
    private let topContainerView = UIView()
    private let rectangleView = UIView()
    private let tableView = UITableView()
    private let confirmButton = UIButton()
    
    private var all = Application.StateType.all
    
    private let titleLabel = BaseLabel(text: "Applications", font: .bold, textColor: .Tint, numberOfLines: 1)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = Constants.bigCornerRadius
        
        topContainerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        topContainerView.layer.cornerRadius = Constants.bigCornerRadius

        confirmButton.layer.cornerRadius = Constants.bigCornerRadius
        confirmButton.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        confirmButton.addTarget(self, action: #selector(onConfirmTapped), for: .touchUpInside)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SortCell.self)
        tableView.bounces = false
        tableView.separatorStyle = .none
        
        layer.borderWidth = 0.5
        
        // Append it manually
        all.append(.All)
        
        setupViewsLayout()
        
        setColors()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        rectangleView.layer.cornerRadius = rectangleView.frame.height / 2
    }
    
    private func setupViewsLayout() {
        
        add(subview: topContainerView) { (v, p) in [
            v.topAnchor.constraint(equalTo: p.topAnchor),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.15)
            ]}
        
        add(subview: rectangleView) { (v, p) in [
            v.topAnchor.constraint(equalTo: p.topAnchor, constant: Constants.padding - 5),
            v.centerXAnchor.constraint(equalTo: p.centerXAnchor),
            v.widthAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.2),
            v.heightAnchor.constraint(equalToConstant: 3)
            ]}
        
        topContainerView.add(subview: titleLabel) { (v, p) in [
            v.centerYAnchor.constraint(equalTo: p.centerYAnchor),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: Constants.padding)
            ]}
        
        add(subview: confirmButton) { (v, p) in [
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.15),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor),
            v.bottomAnchor.constraint(equalTo: p.bottomAnchor)
            ]}
        
        add(subview: tableView) { (v, p) in [
            v.topAnchor.constraint(equalTo: topContainerView.bottomAnchor),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor),
            v.bottomAnchor.constraint(equalTo: confirmButton.topAnchor)
            ]}
    }
    
    @objc private func onConfirmTapped() {
        delegate?.didChooseState(self, state: all[selectedIndex])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setColors() {
        topContainerView.backgroundColor = .SortTopContainer
        
        titleLabel.textColor = .Tint
        
        confirmButton.backgroundColor = .Highlight
        confirmButton.setAttributedTitle(NSAttributedString(string: "Confirm", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.bold]), for: .normal)
        
        rectangleView.backgroundColor = .Secondary
        layer.borderColor = UIColor.lightGray.cgColor

        tableView.reloadData()
    }
}

extension SortView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return all.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(SortCell.self, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! SortCell
        
        cell.model = all[indexPath.row]
        cell.backgroundColor = .SettingsCell
        cell.titleLabel.textColor = .Tint

        if indexPath.row != all.count - 1 {
            cell.addSeparatorLine()
        }
        
        if(indexPath.row == selectedIndex) {
            cell.setAsSelected()
        } else {
            cell.resetSelection()
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / CGFloat(all.count)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row;
        tableView.reloadData()
    }
}
