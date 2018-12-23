//
//  AboutUsSettingsViewController.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 23.12.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class AboutUsSettingsViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupUI() {
        super.setupUI()
        
        let titleLabel = BaseLabel(text: "About Us", font: .regular, textColor: .Tint, numberOfLines: 1)
        navigationItem.titleView = titleLabel
    }
}
