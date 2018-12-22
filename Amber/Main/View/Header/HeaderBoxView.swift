//
//  FilterView.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 20.12.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class HeaderBoxView: UIView {
    
    private let topContainerView = UIView()
    private let bottomContainerView = UIView()
    
    private let imageView = UIImageView()
    private let titleLabel = BaseLabel(font: .regular, textColor: .black, numberOfLines: 1)
    private let subTitleLabel = BaseLabel(font: .medium, textColor: .lightGray, numberOfLines: 1)
    
    // Don't let the name confuse you, it just looks like one
    private let progressBar = UIView()
    private let progressFillView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        topContainerView.layer.cornerRadius = Constants.bigCornerRadius
        topContainerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        addShadows()
        
        imageView.tintColor = .white

        setupViewsLayout()
    }
    
    private func setupViewsLayout() {
        
        // Add Top Container
        add(subview: topContainerView) { (v, p) in [
            v.topAnchor.constraint(equalTo: p.topAnchor),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.5)
            ]}
        
        // Add Bottom Container
        add(subview: bottomContainerView) { (v, p) in [
            v.bottomAnchor.constraint(equalTo: p.bottomAnchor),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.5)
            ]}
        
        // Add ImageView
        topContainerView.add(subview: imageView) { (v, p) in [
            v.centerXAnchor.constraint(equalTo: p.centerXAnchor),
            v.centerYAnchor.constraint(equalTo: p.centerYAnchor),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.45),
            v.widthAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.45)
            ]}
        
        // Add Title Label
        bottomContainerView.add(subview: titleLabel) { (v, p) in [
            v.topAnchor.constraint(equalTo: p.topAnchor, constant: Constants.padding - 5),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: Constants.padding - 5)
            ]}
        
        // Add Subtitle Label
        bottomContainerView.add(subview: subTitleLabel) { (v, p) in [
            v.bottomAnchor.constraint(equalTo: p.bottomAnchor, constant: -Constants.padding + 5),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: Constants.padding - 5)
            ]}
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
    
    func addProgressBar(percentage: CGFloat) {
        bottomContainerView.add(subview: progressBar) { (v, p) in [
            v.bottomAnchor.constraint(equalTo: p.bottomAnchor),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: Constants.padding - 5),
            v.heightAnchor.constraint(equalToConstant: 2),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor, constant: -Constants.padding + 5)
            ]}
        
        progressBar.add(subview: progressFillView) { (v, p) in [
            v.bottomAnchor.constraint(equalTo: p.bottomAnchor),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor),
            v.topAnchor.constraint(equalTo: p.topAnchor),
            v.widthAnchor.constraint(equalTo: p.widthAnchor, multiplier: percentage)
            ]}
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setValues(color: UIColor, image: UIImage, text: String, subText: String) {
        topContainerView.backgroundColor = color
        progressFillView.backgroundColor = color
        imageView.image = image.withRenderingMode(.alwaysTemplate)
        titleLabel.text = text
        subTitleLabel.text = subText
    }
}
