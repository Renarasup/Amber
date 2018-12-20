//
//  UIColor+CustomColors.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 20.12.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

extension UIColor {
    public class var ApplicationHeader: UIColor {
        return UIColor(rgb: 0xC8D6E5).withAlphaComponent(0.65)
    }
    public class var CheatSheetBox: UIColor {
        return UIColor(rgb: 0xD35400)
    }
    public class var LightBackground: UIColor {
        return UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0)
    }
    public class var Accent: UIColor {
        return UIColor(red:0.72, green:0.65, blue:0.49, alpha:1.0)
    }
}
