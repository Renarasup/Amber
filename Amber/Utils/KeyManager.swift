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
    
    var defaultCurrencyIdx: Int {
        get {
            let value = defaults.integer(forKey: Key.defaultCurrencyIdx.rawValue)
            return value
        }
        set {
            defaults.set(newValue, forKey: Key.defaultCurrencyIdx.rawValue)
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
}
extension KeyManager {
    private enum Key: String {
        case sortBy = "sortBy"
        case defaultCurrencyIdx = "defaultCurrencyIdx"
        case defaultCurrency = "defaultCurrency"
    }
}
