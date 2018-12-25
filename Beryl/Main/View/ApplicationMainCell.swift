//
//  ApplicationMainCell.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 20.12.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit
import Kingfisher

protocol ApplicationCellDelegate: class {
    func didLongPress(_ longPressGestureRecognizer: UILongPressGestureRecognizer, in cell: UITableViewCell)
}


class ApplicationMainCell: UITableViewCell {
    
    weak var delegate: ApplicationCellDelegate?

    var model: Application! {
        didSet {
            containerView.backgroundColor = model.stateEnum.color
            applicationToLabel.text = model.applicationToTitle
            jobTitleLabel.text = model.jobTitle
            salaryLabel.text = "\(model.formattedSalary)"
            dateLabel.text = model.sentDate
            
            guard let imageLink = model.imageLink,
                let imageURL = URL(string: imageLink)
                else { return }
            
            companyImageView.kf.setImage(with: imageURL)
        }
    }
    
    private let applicationToLabel = BaseLabel(font: UIFont.bold.withSize(19), textColor: .white, numberOfLines: 1)
    private let jobTitleLabel = BaseLabel(font: .regular, textColor: UIColor.white.withAlphaComponent(0.8), numberOfLines: 1)
    private let salaryLabel = BaseLabel(font: .regular, textColor: UIColor.white.withAlphaComponent(0.8), numberOfLines: 1)
    private let dateLabel = BaseLabel(font: .regular, textColor: UIColor.white.withAlphaComponent(0.8), numberOfLines: 1)

    private let companyImageView = UIImageView()
    
    private let containerView = UIView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        
//        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
//        containerView.layer.shadowOpacity = 1
//        containerView.layer.shadowRadius = 4.0
//        containerView.layer.shadowColor = UIColor.init(rgb: 0x9C9C9C).cgColor
        
        containerView.layer.cornerRadius = Constants.bigCornerRadius
        
        let tapGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(onLongTapped(_:)))
        addGestureRecognizer(tapGestureRecognizer)

        setupViewsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        companyImageView.layer.cornerRadius = (containerView.frame.height * 0.4) / 2
        companyImageView.clipsToBounds = true
    }
    
    private func setupViewsLayout() {
        
        add(subview: containerView) { (v, p) in [
            v.topAnchor.constraint(equalTo: p.topAnchor, constant: Constants.padding - 5),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: Constants.padding),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor, constant: -Constants.padding),
            v.bottomAnchor.constraint(equalTo: p.bottomAnchor, constant: -Constants.padding + 5)
            ]}
        
        containerView.add(subview: companyImageView) { (v, p) in [
            v.topAnchor.constraint(equalTo: p.topAnchor, constant: Constants.padding),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor, constant: -Constants.padding),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.4),
            v.widthAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.4)
            ]}
        
        let sv = UIStackView(arrangedSubviews: [applicationToLabel,jobTitleLabel, salaryLabel, dateLabel])
        sv.distribution = .fillEqually
        sv.axis = .vertical
        
        containerView.add(subview: sv) { (v, p) in [
            v.topAnchor.constraint(equalTo: p.topAnchor, constant: Constants.padding),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: Constants.padding),
            v.trailingAnchor.constraint(equalTo: companyImageView.leadingAnchor, constant: -Constants.padding),
            v.bottomAnchor.constraint(equalTo: p.bottomAnchor, constant: -Constants.padding)
            ]}
    }
    
    @objc private func onLongTapped(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            delegate?.didLongPress(sender, in: self)
        }
    }
    
    // Make it appear to be very responsive to touch
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

// For Preview
extension ApplicationMainCell {
    
    func injectPreviewData(state: Application.StateType) {
        
        UIView.animate(withDuration: 0.25) {
            self.containerView.backgroundColor = state.color

        }
        applicationToLabel.text = "Facebook"
        jobTitleLabel.text = "Software Engineer Intern"
        salaryLabel.text = "\(7500)$ Monthly"
        dateLabel.text = "23.12.2018"
        
        guard let imageURL = URL(string: "https://logo.clearbit.com/facebook.com") else {
            return
        }
        
        companyImageView.kf.setImage(with: imageURL)
    }
}
