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
    
    private let titleLabel = BaseLabel(text: "Applications", font: .regular, textColor: .black, numberOfLines: 1)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = Constants.bigCornerRadius

        rectangleView.backgroundColor = .lightGray
        
        topContainerView.layer.cornerRadius = Constants.bigCornerRadius
        topContainerView.backgroundColor = UIColor.init(rgb: 0xF6F6F6)
        
        confirmButton.backgroundColor = UIColor.Highlight
        confirmButton.setTitle("Confirm", for: .normal)
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.layer.cornerRadius = Constants.bigCornerRadius
        confirmButton.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        confirmButton.addTarget(self, action: #selector(onConfirmTapped), for: .touchUpInside)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SortCell.self)
        tableView.bounces = false
        tableView.separatorStyle = .none
        
        // Append it manually
        all.append(.All)
        
        setupViewsLayout()
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
