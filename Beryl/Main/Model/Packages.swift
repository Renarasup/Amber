//
//  Packages.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 24.12.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

enum Package {
    case allInOne
    case unlimitedApplications
    case design
    
    struct Information {
        let title: String
        let description: String
        let image: UIImage
    }
    
    static func get(_ value: String) -> Package {
        if value == Constants.allInOne {
            return .allInOne
        } else if value == Constants.unlimitedApplications {
            return .unlimitedApplications
        } else if value == Constants.customizeDesign {
            return .design
        }
        return .allInOne
    }
}

extension Package {
    
    var pages: [Information] {
        switch self {
        case .allInOne:
            let page1 = Information(title: "Unlimited Applications", description: "Add and manage more than 5 applications and improve your job hunting experience!", image: #imageLiteral(resourceName: "mainscreen"))
            let page2 = Information(title: "Dark Theme", description: "Elegant dark themed application for comfortable reading.", image: #imageLiteral(resourceName: "darktheme"))
            let page3 = Information(title: "Custom Application Colors", description: "Change the default application state colors to your liking.", image: #imageLiteral(resourceName: "statecolor"))
            
            return [page1, page2, page3]
        case .design:
            let page1 = Information(title: "Dark Theme", description: "Elegant dark themed application for comfortable reading.", image: #imageLiteral(resourceName: "darktheme"))
            let page2 = Information(title: "Custom Application Colors", description: "Change the default application state colors to your liking.", image: #imageLiteral(resourceName: "statecolor"))
            
            return [page1, page2]
        case .unlimitedApplications:
            let page1 = Information(title: "Unlimited Applications", description: "Add and manage more than 5 applications and improve your job hunting experience!", image: #imageLiteral(resourceName: "mainscreen"))
            return [page1]
        }
    }
    
    var price: Double {
        switch self {
        case .allInOne:
            return 1.26
        case .design:
            return 0.9
        case .unlimitedApplications:
            return 0.9
        }
    }
    
    var title: String {
        switch self {
        case .allInOne:
            return "All In One Package"
        case .design:
            return "Customizable Design"
        case .unlimitedApplications:
            return "Unlimited Applications"
        }
    }
    
    var description: String {
        switch self {
        case .allInOne:
            return "Get all premium features at once with a discount!"
        case .design:
            return "Customize your design - switch to a dark theme and choose between different application colors!"
        case .unlimitedApplications:
            return "Need more applications? Add as much as you need by unlocking the applications package."
        }
    }
    
    var image: UIImage {
        switch self {
        case .allInOne:
            return #imageLiteral(resourceName: "amberlogo")
        case .design:
            return #imageLiteral(resourceName: "saturation")
        case .unlimitedApplications:
            return #imageLiteral(resourceName: "infinity")
        }
    }

    static let all: [Package] = [.allInOne, .unlimitedApplications, .design]
}

public struct ApplimeProducts {
    
    private static let productIdentifiers: Set<ProductIdentifier> = [Constants.allInOne, Constants.unlimitedApplications, Constants.customizeDesign]
    
    public static let store = IAPHelper(productIds: ApplimeProducts.productIdentifiers)
}
