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
        case applied, rejected, interview, accepted
    }
    
    var state: StateType
    var applicationToTitle: String
    var sentDate: String
    var jobTitle: String
    var salary: Double
    var zipCode: String
    
    var imageLink: URL?
    var rejectedDate: String?
}

extension Application.StateType {
    var color: UIColor {
        switch self {
        case .applied:
            return UIColor(rgb: 0xb2bec3)
        case .accepted:
            return UIColor(rgb: 0xc0392b)
        case .interview:
            return UIColor(rgb: 0xf39c12)
        case .rejected:
            return UIColor(rgb: 0x2ecc71)
        }
    }
    
    var title: String {
        switch self {
        case .applied:
            return "Applied"
        case .accepted:
            return "Accepted"
        case .interview:
            return "Interview"
        case .rejected:
            return "Rejected"
        }
    }
}

// ToDo: Interview Rounds
