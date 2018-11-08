//
//  ChooseStateViewController.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 04.11.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

protocol ChooseStateViewControllerDelegate: class {
    func didChooseState(_ chooseStateViewController: ChooseStateViewController, state: Application.StateType)
}

class ChooseStateViewController: BaseViewController {
    
    weak var delegate: ChooseStateViewControllerDelegate?
    private let all = Application.StateType.all
    
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChooseStateCell.self)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
        view.fillToSuperview(tableView)
    }
    
    override func setupUI() {
        super.setupUI()
        
        view.backgroundColor = .white
        
        let dropDownBarItem = UIBarButtonItem(image: #imageLiteral(resourceName: "drop_down").withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(onDropDownPressed))
        dropDownBarItem.tintColor = .darkGray
        navigationItem.leftBarButtonItem = dropDownBarItem
        
        // Set back title
        navigationController?.navigationBar.topItem?.title = ""
        
        // Add Title Label
        let titleLabel = BaseLabel(text: "Choose State", font: .regular, textColor: .black, numberOfLines: 1)
        navigationItem.titleView = titleLabel
    }
    
    @objc private func onDropDownPressed() {
        dismiss(animated: true, completion: nil)
    }
}

extension ChooseStateViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return all.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(ChooseStateCell.self, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! ChooseStateCell
        let state = all[indexPath.row]
        
        cell.model = state
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.height * 0.10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let state = all[indexPath.row]

        delegate?.didChooseState(self, state: state)
        dismiss(animated: true, completion: nil)
    }
}
