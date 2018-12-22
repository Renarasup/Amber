//
//  AddApplicationPickers.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 22.12.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

enum SalaryPicker {
    case monthly, yearly
}

extension SalaryPicker {    
    static let dataSource: [String] = [SalaryPicker.yearly.title, SalaryPicker.monthly.title]
    
    var title: String {
        switch self {
        case .monthly:
            return "Monthly"
        case .yearly:
            return "Yearly"
        }
    }
}
