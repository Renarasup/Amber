//
//  SearchApplicationToViewController.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 03.11.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol SearchApplicationToViewControllerDelegate: class {
    func didSelect(_ cell: UITableViewCell, searchApplication: SearchApplication)
}

class SearchApplicationToViewController: BaseViewController {
    
    weak var delegate: SearchApplicationToViewControllerDelegate?
    
    private var searchApplications = [SearchApplication]() {
        didSet {
            tableView.reloadData()
        }
    }

    private let tableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    private let activityIndicator = UIActivityIndicatorView(style: .gray)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchApplicationCell.self)
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activityIndicator)
    
        view.fillToSuperview(tableView)
    }
    
    override func setupUI() {
        super.setupUI()
        
        view.backgroundColor = .white
        
        let dropDownBarItem = UIBarButtonItem(image: #imageLiteral(resourceName: "drop_down").withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(onDropDownPressed))
        dropDownBarItem.tintColor = .darkGray
        navigationItem.leftBarButtonItem = dropDownBarItem
    }
    
    // MARK: - On Pressed Handlers
    /***************************************************************/
    
    @objc private func onDropDownPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: - Networking
    /***************************************************************/
    
    func getAutoCompletionData(applicationTo: String) {
        
        Alamofire.request(URL(string: "\(BaseConfig.shared.autoCompletionURLString)companies/suggest?query=\(applicationTo.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? "")")!, method: .get).responseJSON { (response) in
            if response.result.isSuccess {
                let autoCompletionJSON: JSON = JSON(response.result.value!)
                self.updateAutoCompletionData(json: autoCompletionJSON)
            } else {
                print("error")
            }
        }
    }
    
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
    
    func updateAutoCompletionData(json: JSON) {
        
        if let data = json.array {
            let searchApplications = data.compactMap({ item -> SearchApplication in
                let logoPath = item["logo"].stringValue
                let name = item["name"].stringValue
                let domain = item["domain"].stringValue
                return SearchApplication(logoPath: logoPath, name: name, domain: domain)
            })
            
            self.searchApplications = searchApplications
            activityIndicator.stopAnimating()
        }
    }
}

extension SearchApplicationToViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchApplications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(SearchApplicationCell.self, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let searchApplication = searchApplications[indexPath.row]
        let cell = cell as! SearchApplicationCell
        cell.model = searchApplication
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        view.endEditing(true)
        
        let searchApplication = searchApplications[indexPath.row]
        dismiss(animated: true, completion: nil)
        delegate?.didSelect(tableView.cellForRow(at: indexPath) ?? UITableViewCell(), searchApplication: searchApplication)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.height / 10
    }
}

extension SearchApplicationToViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        activityIndicator.startAnimating()
        if !searchText.isEmpty {
            getAutoCompletionData(applicationTo: searchText)
        } else {
            searchApplications = []
            activityIndicator.stopAnimating()
        }
    }
    
}
