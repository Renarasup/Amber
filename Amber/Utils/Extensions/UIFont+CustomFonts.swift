//
//  UIFont+CustomFonts.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 02.11.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

extension UIFont {
    public class var bold: UIFont {
        return UIFont(name: "Roboto-Bold", size: 17.0)! // ?? UIFont.systemFont(ofSize: 15.0, weight: UIFontWeightBlack)
    }
    public class var regular: UIFont {
        return UIFont(name: "Roboto-Regular", size: 17.0)! // ?? UIFont.systemFont(ofSize: 15.0, weight: UIFontWeightBlack)
    }
    public class var medium: UIFont {
        return UIFont(name: "Roboto-Regular", size: 15.0)! // ?? UIFont.systemFont(ofSize: 15.0, weight: UIFontWeightBlack)
    }
    public class var light: UIFont {
        return UIFont(name: "Roboto-Regular", size: 12.0)! // ?? UIFont.systemFont(ofSize: 15.0, weight: UIFontWeightBlack)
    }
}
