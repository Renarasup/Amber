//
//  BoxStateView.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 02.11.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class BoxStateView: UIView {
    
    private let stateLabel = BaseLabel(font: .light, textColor: .white, numberOfLines: 1)
    
    init(state: Application.StateType) {
        super.init(frame: .zero)
        
        backgroundColor = state.color
        stateLabel.text = state.title
        stateLabel.textAlignment = .center
        
        add(subview: stateLabel) { (v, p) in [
            v.centerYAnchor.constraint(equalTo: p.centerYAnchor),
            v.centerXAnchor.constraint(equalTo: p.centerXAnchor),
            v.widthAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.7)
            ]}
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
