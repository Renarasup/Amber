//
//  KeyManager.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 23.12.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

class KeyManager {
    static let shared = KeyManager()
    
    private let defaults = UserDefaults.standard
    
    var sortBy: Int {
        get {
            let value = defaults.integer(forKey: Key.sortBy.rawValue)
            return value
        }
        set {
            defaults.set(newValue, forKey: Key.sortBy.rawValue)
        }
    }
    
    var defaultCurrency: String {
        get {
            let value = defaults.string(forKey: Key.defaultCurrency.rawValue)
            return value ?? "EUR (€)"
        }
        set {
            defaults.set(newValue, forKey: Key.defaultCurrency.rawValue)
        }
    }
    
    var theme: String {
        get {
            let value = defaults.string(forKey: Key.theme.rawValue)
            return value ?? "Light"
        }
        set {
            defaults.set(newValue, forKey: Key.theme.rawValue)
        }
    }
    
    var acceptedColor: String {
        get {
            let value = defaults.string(forKey: Key.acceptedColor.rawValue)
            return value ?? ""
        }
        set {
            defaults.set(newValue, forKey: Key.acceptedColor.rawValue)
        }
    }
    
    var appliedColor: String {
        get {
            let value = defaults.string(forKey: Key.appliedColor.rawValue)
            return value ?? ""
        }
        set {
            defaults.set(newValue, forKey: Key.appliedColor.rawValue)
        }
    }
    
    var interviewColor: String {
        get {
            let value = defaults.string(forKey: Key.interviewColor.rawValue)
            return value ?? ""
        }
        set {
            defaults.set(newValue, forKey: Key.interviewColor.rawValue)
        }
    }
    
    var rejectedColor: String {
        get {
            let value = defaults.string(forKey: Key.rejectedColor.rawValue)
            return value ?? ""
        }
        set {
            defaults.set(newValue, forKey: Key.rejectedColor.rawValue)
        }
    }
    
}
extension KeyManager {
    private enum Key: String {
        case sortBy = "sortBy"
        case defaultCurrency = "defaultCurrency"
        case theme = "theme"
        case acceptedColor = "acceptedColor"
        case appliedColor = "appliedColor"
        case interviewColor = "interviewColor"
        case rejectedColor = "rejectedColor"
    }
}
