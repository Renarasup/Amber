//
//  UIView+AddSeparatorLine.swift
//  Beryl
//
//  Created by Giancarlo Buenaflor on 25.12.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

public extension UIView {
    
    enum LineAnchors {
        case top
        case bottom
    }
    
    /// Set a separator line below the view.
    ///
    /// - Parameters:
    ///   - color: color for the line.
    ///   - width: width for the line.
    public func addSeparatorLine(to anchor: LineAnchors, color: UIColor, height: CGFloat) {
        let view = UIView()
        view.backgroundColor = color
        
        switch anchor {
        case .top:
            add(subview: view) { (v, p) in [
                v.topAnchor.constraint(equalTo: p.topAnchor),
                v.leadingAnchor.constraint(equalTo: p.leadingAnchor),
                v.trailingAnchor.constraint(equalTo: p.trailingAnchor),
                v.heightAnchor.constraint(equalToConstant: height)
                ]}
        case .bottom:
            add(subview: view) { (v, p) in [
                v.bottomAnchor.constraint(equalTo: p.bottomAnchor),
                v.leadingAnchor.constraint(equalTo: p.leadingAnchor),
                v.trailingAnchor.constraint(equalTo: p.trailingAnchor),
                v.heightAnchor.constraint(equalToConstant: height)
                ]}
        }
    }
}
