//
//  SortBy.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 23.12.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

enum SortBy: Int {
    case latest = 0, companyName, status, date
}

extension SortBy {
    static let all: [SortBy] = [.latest, .companyName, .status, .date]
    
    var title: String {
        switch self {
        case .companyName:
            return "Company Name"
        case .latest:
            return "Latest"
        case .status:
            return "Status"
        case .date:
            return "Date"
        }
    }
}
