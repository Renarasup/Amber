//
//  AddApplicationsViewController.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 02.11.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class AddApplicationsViewController: BaseViewController {
    
    var coordinator: ApplicationsCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // **** Basic UI Setup For The ViewController ****
    override func setupUI() {
        super.setupUI()
        
        view.backgroundColor = .white
        
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = .darkGray
    }
}
