//
//  Application.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 02.11.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

struct Application {
    
    enum StateType {
        case Applied, Rejected, Interview, Accepted
    }
    
    var state: StateType
    var applicationToTitle: String
    var sentDate: String
    var jobTitle: String
    var salary: Double
    var zipCode: String
    
    var note: String?
    var imageLink: URL?
    var rejectedDate: String?
}

extension Application {
    enum Information {
        case State, Job, Salary, ApplicationTo, Date, Note
        
        static let all: [Application.Information] = [ ApplicationTo, Job, Salary, State, Date ]
    }
}

extension Application.Information {
    var title: String {
        switch self {
        case .ApplicationTo:
            return "Application To"
        case .State:
            return "Current State"
        case .Job:
            return "Job Title"
        default:
            return "\(self)"
        }
    }
}

extension Application.StateType {
    var color: UIColor {
        switch self {
        case .Applied:
            return UIColor(rgb: 0xb2bec3)
        case .Accepted:
            return UIColor(rgb: 0xc0392b)
        case .Interview:
            return UIColor(rgb: 0xf39c12)
        case .Rejected:
            return UIColor(rgb: 0x2ecc71)
        }
    }
    
    var title: String {
        return "\(self)"
    }
}

// ToDo: Interview Rounds
