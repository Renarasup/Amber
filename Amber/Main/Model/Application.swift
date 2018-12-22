//
//  Application.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 02.11.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit
import RealmSwift

class Application: Object {
    
    enum StateType: Int {
        case Applied = 0, Rejected, Interview, Accepted, All
    }
    
    @objc dynamic var state = StateType.Applied.rawValue
    var stateEnum: StateType {
        get {
            return StateType(rawValue: state)!
        }
        set {
            state = newValue.rawValue
        }
    }
    
    @objc dynamic var applicationToTitle: String = ""
    @objc dynamic var sentDate: String = ""
    @objc dynamic var jobTitle: String = ""
    @objc dynamic var salary: Double = 0
    @objc dynamic var zipCode: String = ""
    
    @objc dynamic var note: String? = nil
    @objc dynamic var imageLink: String? = nil
    @objc dynamic var rejectedDate: String? = nil
}

extension Application {
    enum Information {
        case State, Job, Salary, ApplicationTo, Date, Note, ZipCode
        
        static let all: [Application.Information] = [ ApplicationTo, Job, Salary, State, Date]
    }
}

extension Application.Information {
    var title: String {
        switch self {
        case .ApplicationTo:
            return "Company"
        case .State:
            return "Status"
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
            return UIColor(rgb: 0x95A5A6)
        case .Accepted:
            return UIColor(rgb: 0x2ecc71)
        case .Interview:
            return UIColor(rgb: 0xFF9F43) //f39c12
        case .Rejected:
            return UIColor(rgb: 0xc0392b)
        case .All:
            return UIColor(rgb: 0xc3498db)
        }
    }
    
    var title: String {
        return "\(self)"
    }
    
    static let all: [Application.StateType] = [ .Applied, .Accepted, .Interview, .Rejected ]
}

// ToDo: Interview Rounds
