//
//  AddApplicationsViewController.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 02.11.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class AddApplicationsViewController: BaseViewController {
    
    // Instance Variables
    var coordinator: ApplicationsCoordinator?
    
    private let allInformation = Application.Information.all
    
    // UI Views
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    // Children VC
    private let lineCircleVC = LineCircleViewController()
    
    // MARK: - Setup Core Components & Delegations
    /***************************************************************/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(InformationCell.self)

        setupLayoutViews()
    }
    
    private func setupLayoutViews() {
        addLineCircleVC()

        view.add(subview: collectionView) { (v, p) in [
            v.topAnchor.constraint(equalTo: lineCircleVC.view.topAnchor),
            v.leadingAnchor.constraint(equalTo: lineCircleVC.view.trailingAnchor),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor),
            v.heightAnchor.constraint(equalTo: lineCircleVC.view.heightAnchor, multiplier: 0.85)
            ]}
    }
    
    private func addLineCircleVC() {
        addChild(lineCircleVC)
        view.add(subview: lineCircleVC.view) { (v, p) in [
            v.topAnchor.constraint(equalTo: p.safeAreaLayoutGuide.topAnchor, constant: 12),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.5),
            v.widthAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.22)
            ]}
        
        
        lineCircleVC.didMove(toParent: self)
    }
    
    // **** Basic UI Setup For The ViewController ****
    override func setupUI() {
        super.setupUI()
        
        view.backgroundColor = .white
        
        // Set back title
        navigationController?.navigationBar.topItem?.title = ""
        
        // Add Title Label
        let titleLabel = BaseLabel(text: "My Applications", font: .regular, textColor: .black, numberOfLines: 1)
        navigationItem.titleView = titleLabel
    }
}

// MARK: - UICollectionView Delegate & DataSource Extension
/***************************************************************/

extension AddApplicationsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allInformation.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(InformationCell.self, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let information = allInformation[indexPath.row]
        let cell = cell as! InformationCell
        
        cell.model = information
        
        cell.textField.isUserInteractionEnabled = indexPath.row == 0 ? false : true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            coordinator?.showSearchApplicationsToScreen(addApplicationsVC: self)
        } else {
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height / CGFloat(allInformation.count))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


// MARK: - Search Application VC Delegate
/***************************************************************/

extension AddApplicationsViewController: SearchApplicationToViewControllerDelegate {
    
    func didSelect(_ cell: UITableViewCell, searchApplication: SearchApplication) {
        let cell = collectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as! InformationCell
        cell.textField.text = searchApplication.name
    }
}
