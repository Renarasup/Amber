//
//  Coordinator.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 30.10.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [String: Coordinator] { get set }
    var navigationController: CustomNavigationController { get set }
    
    func start()
}
