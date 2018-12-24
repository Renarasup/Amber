//
//  UIView+Shadows.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 21.12.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

extension UIView {
    func addShadows() {
        layer.shadowOffset = CGSize(width: 0, height: 1.5)
        layer.shadowOpacity = 1
        layer.shadowRadius = 2.0
        layer.shadowColor = UIColor.init(rgb: 0x9C9C9C).cgColor
    }
}

