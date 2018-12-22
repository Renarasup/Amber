//
//  AddApplicationCell.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 21.12.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit
import Kingfisher

class AddApplicationCell: UICollectionViewCell {
    
    var model: Application.Information! {
        didSet {
            textField.attributedPlaceholder = NSAttributedString(string: model.title, attributes: textFieldPlaceholderAttributes)
        }
    }
    
    private let containerView = UIView()
    private let textField = UITextField()
    private let imageView = UIImageView()
    
    private let textFieldPlaceholderAttributes = [
        NSAttributedString.Key.foregroundColor: UIColor.lightGray,
        NSAttributedString.Key.font : UIFont.bold
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        containerView.backgroundColor = UIColor.init(rgb: 0xE9E9E9)
        containerView.layer.cornerRadius = Constants.bigCornerRadius
        
        textField.autocorrectionType = .no
        
        let doneToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        doneToolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(onDoneToolBarTapped))]
        doneToolbar.sizeToFit()
        doneToolbar.tintColor = .Highlight
        textField.inputAccessoryView = doneToolbar
        
        addShadows()
        
        setupViewsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.clipsToBounds = true
    }
    
    private func setupViewsLayout() {
        add(subview: containerView) { (v, p) in [
            v.topAnchor.constraint(equalTo: p.topAnchor, constant: 5),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: Constants.padding),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor, constant: -Constants.padding),
            v.bottomAnchor.constraint(equalTo: p.bottomAnchor, constant: -Constants.padding + 5)
            ]}
        
        containerView.add(subview: textField) { (v, p) in [
            v.centerYAnchor.constraint(equalTo: p.centerYAnchor),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: Constants.padding),
            v.widthAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.7),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.7)
            ]}
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func onDoneToolBarTapped() {
        endEditing(true)
    }
    
    func update(text: String) {
        
    }
    
    func update(text: String, imageLink: String) {
        
        textField.text = text
        
        guard let url = URL(string: imageLink) else {
            return
        }
        imageView.kf.setImage(with: url)
    }
    
    func setSearchCompanyMode() {
        containerView.add(subview: imageView) { (v, p) in [
            v.centerYAnchor.constraint(equalTo: p.centerYAnchor),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor, constant: -Constants.padding),
            v.widthAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.7),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.7)
            ]}
    
        textField.isUserInteractionEnabled = false
    }
}
