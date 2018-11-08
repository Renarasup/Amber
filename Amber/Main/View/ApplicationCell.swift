//
//  ApplicationCell.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 02.11.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit
import Kingfisher

protocol ApplicationCellDelegate: class {
    func didLongPress(_ longPressGestureRecognizer: UILongPressGestureRecognizer, in cell: UITableViewCell)
}

class ApplicationCell: UITableViewCell {
    
    weak var delegate: ApplicationCellDelegate?
    
    var model: Application! {
        didSet {
            dateLabel.text = model.sentDate
            applicationToLabel.text = model.applicationToTitle
            verticalLineView.backgroundColor = model.stateEnum.color
            
            zipCodeLabel.text = "Location: \(model.zipCode)"
            jobTitleLabel.text = "Job Title: \(model.jobTitle)"
            salaryLabel.text = "Yearly Salary: \(model.salary) €"
            
            setupViewsLayout()
            
            guard let imageLink = model.imageLink,
                let imageURL = URL(string: imageLink)
                else { return }
            
            logoImageView.kf.setImage(with: imageURL)
        }
    }
    
    private let verticalLineWidth: CGFloat = 5
    
    private let logoImageView = UIImageView()
    private let applicationToLabel = BaseLabel(font: .regular, textColor: .black, numberOfLines: 1)
    private let dateLabel = BaseLabel(font: .light, textColor: UIColor(rgb: 0x2D3436), numberOfLines: 1)
    private let zipCodeLabel = BaseLabel(font: .light, textColor: UIColor(rgb: 0x2D3436), numberOfLines: 1)
    private let jobTitleLabel = BaseLabel(font: .light, textColor: UIColor(rgb: 0x2D3436), numberOfLines: 1)
    private let salaryLabel = BaseLabel(font: .light, textColor: UIColor(rgb: 0x2D3436), numberOfLines: 1)

    private let verticalLineView = UIView()
    private lazy var informationStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [jobTitleLabel, salaryLabel, zipCodeLabel])
        sv.distribution = .equalSpacing
        sv.axis = .vertical
        return sv
    }()
    
    private let containerView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Other UI Styling
        selectionStyle = .none
        logoImageView.backgroundColor = .red
        dateLabel.textAlignment = .right
        verticalLineView.layer.cornerRadius = verticalLineWidth / 2
        
        let tapGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(onLongTapped(_:)))
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func setupViewsLayout() {
        add(subview: containerView) { (v, p) in [
            v.topAnchor.constraint(equalTo: p.topAnchor, constant: 12),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: 30),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor, constant: -30),
            v.bottomAnchor.constraint(equalTo: p.bottomAnchor)
            ]}
        
        containerView.add(subview: logoImageView) { (v, p) in [
            v.topAnchor.constraint(equalTo: p.topAnchor),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.23),
            v.widthAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.23)
            ]}
        
        let boxStateView = BoxStateView(state: model.stateEnum)
        boxStateView.layer.cornerRadius = 2
        
        containerView.add(subview: boxStateView) { (v, p) in [
            v.centerXAnchor.constraint(equalTo: p.centerXAnchor),
            v.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.15),
            v.widthAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.23)
            ]}
        
        containerView.add(subview: dateLabel) { (v, p) in [
            v.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor),
            v.leadingAnchor.constraint(equalTo: boxStateView.trailingAnchor, constant: 5)
            ]}
        
        containerView.add(subview: applicationToLabel) { (v, p) in [
            v.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor),
            v.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 10),
            v.trailingAnchor.constraint(equalTo: boxStateView.leadingAnchor, constant: -10)
            ]}
    
        containerView.add(subview: verticalLineView) { (v, p) in [
            v.topAnchor.constraint(equalTo: applicationToLabel.bottomAnchor, constant: 10),
            v.leadingAnchor.constraint(equalTo: applicationToLabel.leadingAnchor, constant: 15),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.55),
            v.widthAnchor.constraint(equalToConstant: verticalLineWidth)
            ]}
        
        containerView.add(subview: informationStackView) { (v, p) in [
            v.topAnchor.constraint(equalTo: verticalLineView.topAnchor, constant: 3),
            v.leadingAnchor.constraint(equalTo: verticalLineView.trailingAnchor, constant: 10),
            v.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
            v.bottomAnchor.constraint(equalTo: verticalLineView.bottomAnchor, constant: -3)
            ]}
    }
    
    @objc private func onLongTapped(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            delegate?.didLongPress(sender, in: self)
        }
    }
    
    // Make it appears very responsive to touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        animate(isHighlighted: true)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        animate(isHighlighted: false)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        animate(isHighlighted: false)
    }
    
    private func animate(isHighlighted: Bool, completion: ((Bool) -> Void)?=nil) {
//        if disabledHighlightedAnimation {
//            return
//        }
//        let animationOptions: UIViewAnimationOptions = GlobalConstants.isEnabledAllowsUserInteractionWhileHighlightingCard
        let animationOptions: UIView.AnimationOptions = true ? [.allowUserInteraction] : []
        if isHighlighted {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 0,
                           options: animationOptions, animations: {
                            self.transform = .init(scaleX: 0.96, y: 0.96)
            }, completion: completion)
        } else {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 0,
                           options: animationOptions, animations: {
                            self.transform = .identity
            }, completion: completion)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
