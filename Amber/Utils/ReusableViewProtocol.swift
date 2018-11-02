//
//  ReusableProtocols.swift
//  RestaurantTracker
//
//  Created by Giancarlo Buenaflor on 30.09.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

// Model for the generic usage of TableView & CollectionView

/// Protocol for setting the defaultReuseIdentifier
public protocol ReusableView: class {
    static var defaultReuseIdentifier: String { get }
}

public extension ReusableView where Self: UIView {
    
    /// Grabs the defaultReuseIdentifier through the class name
    static var defaultReuseIdentifier: String {
        return NSStringFromClass(self)
    }
}
