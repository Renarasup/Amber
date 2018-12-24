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
    @objc dynamic var salaryCurrencySymbol: String = ""
    @objc dynamic var salaryCurrencyCode: String = ""
    @objc dynamic var salaryPayCycle: String = ""
    @objc dynamic var note: String? = nil
    @objc dynamic var imageLink: String? = nil
    @objc dynamic var rejectedDate: String? = nil
}

extension Application {
    var formattedSalary: String {
        return "\(salaryWithoutDecimal)\(salaryCurrencySymbol) \(salaryPayCycle)"
    }
    var salaryWithoutDecimal: String {
        return String(format: "%.0f", salary)
    }
}

extension Application {
    enum Information {
        case State, Job, Salary, ApplicationTo, Date, Note
        
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
            if KeyManager.shared.appliedColor.isEmpty {
                KeyManager.shared.appliedColor = "95A5A6"
            }
            return UIColor(hexString: KeyManager.shared.appliedColor)
        case .Accepted:
            if KeyManager.shared.acceptedColor.isEmpty {
                KeyManager.shared.acceptedColor = "2ecc71"
            }
            return UIColor(hexString: KeyManager.shared.acceptedColor)
        case .Interview:
            if KeyManager.shared.interviewColor.isEmpty {
                KeyManager.shared.interviewColor = "FF9F43"
            }
            return UIColor(hexString: KeyManager.shared.interviewColor)
        case .Rejected:
            if KeyManager.shared.rejectedColor.isEmpty {
                KeyManager.shared.rejectedColor = "c0392b"
            }
            return UIColor(hexString: KeyManager.shared.rejectedColor)
        case .All:
            return UIColor(rgb: 0xc3498db)
        }
    }
    
    var multiColors: [ChooseStateColor] {
        switch self {
        case .Applied:
            let color1 = ChooseStateColor(state: self, color: UIColor(rgb: 0x95A5A6), title: "Default")
            let color2 = ChooseStateColor(state: self, color: UIColor(rgb: 0x7f8c8d), title: "Asbestos")
            let color3 = ChooseStateColor(state: self, color: UIColor(rgb: 0x636e72), title: "American River")
            let color4 = ChooseStateColor(state: self, color: UIColor(rgb: 0x2d3436), title: "Dracula Orchid")
            return [color1, color2, color3, color4]
        case .Accepted:
            let color1 = ChooseStateColor(state: self, color: UIColor(rgb: 0x2ecc71), title: "Default")
            let color2 = ChooseStateColor(state: self, color: UIColor(rgb: 0x27ae60), title: "Nepthritis")
            let color3 = ChooseStateColor(state: self, color: UIColor(rgb: 0x009432), title: "Pixelated Grass")
            let color4 = ChooseStateColor(state: self, color: UIColor(rgb: 0x10ac84), title: "Dracula Orchid")
            return [color1, color2, color3, color4]
        case .Interview:
            let color1 = ChooseStateColor(state: self, color: UIColor(rgb: 0xFF9F43), title: "Default")
            let color2 = ChooseStateColor(state: self, color: UIColor(rgb: 0xe15f41), title: "Tigerlily")
            let color3 = ChooseStateColor(state: self, color: UIColor(rgb: 0xe67e22), title: "Carrot")
            let color4 = ChooseStateColor(state: self, color: UIColor(rgb: 0xd35400), title: "Pumpkin")
            return [color1, color2, color3, color4]
        case .Rejected:
            let color1 = ChooseStateColor(state: self, color: UIColor(rgb: 0xc0392b), title: "Default")
            let color2 = ChooseStateColor(state: self, color: UIColor(rgb: 0xe74c3c), title: "Alizarin")
            let color3 = ChooseStateColor(state: self, color: UIColor(rgb: 0xe84118), title: "Nasturcian Flower")
            let color4 = ChooseStateColor(state: self, color: UIColor(rgb: 0xb33939), title: "Eye of Newt")
            return [color1, color2, color3, color4]
        default:
            return []
        }
    }
    
    var title: String {
        return "\(self)"
    }
    
    static let all: [Application.StateType] = [ .Applied, .Rejected, .Interview, .Accepted ]
    
    static let dataSource: [String] = [Application.StateType.Applied.title, Application.StateType.Rejected.title, Application.StateType.Interview.title, Application.StateType.Accepted.title]
}
