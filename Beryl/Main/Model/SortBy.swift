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
    
    func put(applications: [Application]) -> [Application] {
        switch self {
        case .companyName:
            return applications.sorted(by: { $0.applicationToTitle < $1.applicationToTitle })
        case .latest:
            return applications.reversed()
        case .date:
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            return applications.sorted { dateFormatter.date(from: $0.sentDate)! > dateFormatter.date(from: $1.sentDate)! }
        case .status:
            return applications.sorted(by: { $0.state > $1.state })
        }
    }
}
