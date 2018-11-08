//
//  SettingsViewController.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 02.11.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class SettingsViewController: BaseViewController {
    
    var coordinator: ApplicationsCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupUI() {
        super.setupUI()
        
        view.backgroundColor = .white
        
        let dropDownBarItem = UIBarButtonItem(image: #imageLiteral(resourceName: "drop_down").withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(onDropDownPressed))
        dropDownBarItem.tintColor = .darkGray
        navigationItem.leftBarButtonItem = dropDownBarItem
    }
    
    @objc private func onDropDownPressed() {
        dismiss(animated: true, completion: nil)
    }
}
