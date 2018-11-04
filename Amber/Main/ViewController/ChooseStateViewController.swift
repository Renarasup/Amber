//
//  ChooseStateViewController.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 04.11.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class ChooseStateViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func setupUI() {
        super.setupUI()
        
        view.backgroundColor = .white
        
        // Set back title
        navigationController?.navigationBar.topItem?.title = ""
        
        // Add Title Label
        let titleLabel = BaseLabel(text: "Choose State", font: .regular, textColor: .black, numberOfLines: 1)
        navigationItem.titleView = titleLabel
    }
}
