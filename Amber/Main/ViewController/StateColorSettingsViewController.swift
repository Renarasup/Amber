//
//  StateColorSettingsViewController.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 23.12.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class StateColorSettingsViewController: BaseViewController {
    
    var coordinator: ApplicationsCoordinator?
    
    private let titleLabel = BaseLabel(text: "State Colors", font: .regular, textColor: .Tint, numberOfLines: 1)
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private var all = Application.StateType.all

    
//    func getSelectedIndex() -> Int {
//        return all.firstIndex(where: { (theme) -> Bool in
//            if theme == KeyManager.shared.theme {
//                return true
//            }
//            return false
//        }) ?? 0
//    }
    
    // Needed to stay at root navController which is settingsVC in this case
    private var settingsVC: SettingsViewController!
    
    init(settingsVC: SettingsViewController) {
        super.init(nibName: nil, bundle: nil)
        self.settingsVC = settingsVC
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChooseStateCell.self)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .Main
        
        view.fillToSuperview(tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func setupUI() {
        super.setupUI()

        // Add Title Label
        navigationItem.titleView = titleLabel
    }
}

extension StateColorSettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return all.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(ChooseStateCell.self, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! ChooseStateCell
        let state = all[indexPath.row]
        cell.backgroundColor = .Main
        cell.model = state
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.height * 0.10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let state = all[indexPath.row]
        coordinator?.showChooseStateColorsScreen(settingsVC: settingsVC, state: state)
    }
}
