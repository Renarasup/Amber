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
            
            guard let model = model else {
                return
            }
            
            if model == .Salary {
                textField.keyboardType = .numberPad
            }
            
            guard let application = application else { return }
            
            switch model {
            case .ApplicationTo:
                textField.text = application.applicationToTitle

                guard
                    let imageLink = application.imageLink,
                    let imageURL = URL(string: imageLink)
                    else { return }
                
                addLogoImage()
                logoImageView.kf.setImage(with: imageURL)
            case .Job:
                textField.text = application.jobTitle
            case .Salary:
                textField.text = "\(application.salary)"
            case .State:
                addStateView(application.stateEnum)
                textField.text = application.stateEnum.title
            case .Date:
                textField.text = application.sentDate
            case .ZipCode:
                textField.text = application.zipCode
            default:
                break
            }
        }
    }
    
    var application: Application?
    
    let textField = UITextField()
    var isFilled = false
    var state: Application.StateType?
    var searchApplication: SearchApplication?
    
    private let circleView = UIView()
    private let lineBottomView = UIView()
    private let lineTopView = UIView()
    private let logoImageView = UIImageView()
    private let separatorLine = UIView()
    
    private let stateContainerView = UIView()
    private let stateTitleLabel = BaseLabel(font: .regular, textColor: .white, numberOfLines: 1)
    
    private let circleHeight: CGFloat = UIScreen.main.bounds.width * 0.05
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        separatorLine.backgroundColor = .darkGray
        textField.backgroundColor = .clear
        
        circleView.backgroundColor = UIColor(rgb: 0x3498db)
        lineBottomView.backgroundColor = UIColor(rgb: 0x3498db)
        lineTopView.backgroundColor = UIColor(rgb: 0x3498db)
        
        textField.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
        textField.delegate = self
        
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
            v.leadingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: 40),
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

    func addLogoImage(_ image: UIImage?=nil) {
        add(subview: logoImageView) { (v, p) in [
            v.bottomAnchor.constraint(equalTo: separatorLine.topAnchor, constant: -5),
            v.trailingAnchor.constraint(equalTo: separatorLine.trailingAnchor),
            v.widthAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.35),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.35)
            ]}
        
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.image = image ?? nil
    }
    
    func addSearchApplication(_ searchApplication: SearchApplication) {
        textField.text = searchApplication.name
        self.searchApplication = searchApplication
    }
    
    func addStateView(_ state: Application.StateType) {
        
        stateContainerView.layer.cornerRadius = 5
        stateContainerView.backgroundColor = state.color
        stateTitleLabel.text = state.title
        
        add(subview: stateContainerView) { (v, p) in [
            v.bottomAnchor.constraint(equalTo: separatorLine.topAnchor, constant: -5),
            v.leadingAnchor.constraint(equalTo: separatorLine.leadingAnchor),
            v.widthAnchor.constraint(equalTo: separatorLine.widthAnchor, multiplier: 0.5),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.4)
            ]}
        
        stateContainerView.add(subview: stateTitleLabel) { (v, p) in [
            v.centerXAnchor.constraint(equalTo: p.centerXAnchor),
            v.centerYAnchor.constraint(equalTo: p.centerYAnchor)
            ]}
        
        self.state = state
    }
    
    @objc private func textDidChange(_ sender: UITextField) {
        guard let text = sender.text else { return }
        
        if !text.isEmpty {
            isFilled = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InformationCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }
}
