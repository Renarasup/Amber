//
//  UIColor+CustomColors.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 20.12.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

extension UIColor {
//    public class var Highlight: UIColor {
//        return UIColor(rgb: 0x30336b)
//    }
    public class var ApplicationHeader: UIColor {
        return UIColor(rgb: 0xc7ecee)
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

extension UIColor {
    
    @nonobjc static var Highlight: UIColor!
    @nonobjc static var HighlightTint: UIColor!
    @nonobjc static var Main: UIColor!
    @nonobjc static var SortTopContainer: UIColor!
    @nonobjc static var Secondary: UIColor!
    @nonobjc static var Tint: UIColor!
    @nonobjc static var ReverseTint: UIColor!
    @nonobjc static var TableViewHeader: UIColor!
    @nonobjc static var SettingsCell: UIColor!
    @nonobjc static var AddApplicationCell: UIColor!
    @nonobjc static var Placeholder: UIColor!
    @nonobjc static var Separator: UIColor!
    
    static func initWithColorScheme(cs: ColorScheme){
        switch cs {
        case .Light:
            Highlight = UIColor(rgb: 0x30336b)
            HighlightTint = Highlight
            Main = .white
            Secondary = UIColor(rgb: 0xF7F7F7)
            SortTopContainer = UIColor(rgb: 0xecf0f1)
            Tint = .black
            ReverseTint = .white
            TableViewHeader = UIColor(rgb: 0x969696)
            SettingsCell = .white
            AddApplicationCell = UIColor(rgb: 0xE9E9E9)
            Placeholder = .lightGray
            Separator = .lightGray
        case .Dark:
            Main = UIColor(rgb: 0x161718)
            Highlight = Main
            HighlightTint = .white
            Tint = .white
            Secondary = Main
            SortTopContainer = Main
            SettingsCell = UIColor(rgb: 0x1F2022)
            TableViewHeader = UIColor(rgb: 0xABABAB)
            AddApplicationCell = SettingsCell
            Placeholder = .darkGray
            ReverseTint = .black
            Separator = .darkGray
        }
    }
    
}

enum ColorScheme: String {
    case Light, Dark
}
