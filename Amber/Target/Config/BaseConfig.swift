//
//  BaseConfig.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 02.11.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

class BaseConfig {
    
    static let shared = BaseConfig()
    
    var autoCompletionURLString: String {
        return "https://autocomplete.clearbit.com/v1/"
    }
}
