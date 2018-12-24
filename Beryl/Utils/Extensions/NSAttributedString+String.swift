//
//  NSAttributedString+String.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 24.12.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

public extension NSAttributedString {
    
    static func String(_ string: String, font: UIFont, color: UIColor) -> NSAttributedString {
        return NSAttributedString(string: string, attributes: [NSAttributedString.Key.font : font, NSAttributedString.Key.foregroundColor: color])
    }
}
