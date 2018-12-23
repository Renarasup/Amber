//
//  ChooseStateViewController.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 04.11.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

protocol ChooseStateColorViewControllerDelegate: class {
    func didChooseStateColor(_ chooseStateViewController: ChooseStateColorViewController, state: Application.StateType, color: UIColor)
}

class ChooseStateColorViewController: BaseViewController {
    
    weak var delegate: ChooseStateColorViewControllerDelegate?
    
    private let cvHeaderTitleLabel = BaseLabel(text: "COLORS", font: UIFont.regular.withSize(13), textColor: .TableViewHeader, numberOfLines: 1)
    private let cvPreviewTitleLabel = BaseLabel(text: "PREVIEW", font: UIFont.regular.withSize(13), textColor: .TableViewHeader, numberOfLines: 1)

    // UI Views
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    private var all = [ChooseStateColor]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private let previewCell = ApplicationMainCell(frame: .zero)

    private var state = Application.StateType.Applied
    
    init(state: Application.StateType) {
        super.init(nibName: nil, bundle: nil)
        
        self.state = state
        all = state.multiColors
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ChooseStateColorCell.self)
        collectionView.backgroundColor = .Main
        
        previewCell.injectPreviewData(state: state)
        
        view.add(subview: cvHeaderTitleLabel) { (v, p) in [
            v.topAnchor.constraint(equalTo: p.safeAreaLayoutGuide.topAnchor, constant: Constants.padding),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: Constants.padding)
            ]}
        
        view.add(subview: collectionView) { (v, p) in [
            v.topAnchor.constraint(equalTo: cvHeaderTitleLabel.bottomAnchor, constant: 5),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.45)
            ]}
        
        view.add(subview: cvPreviewTitleLabel) { (v, p) in [
            v.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: Constants.padding),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: Constants.padding)
            ]}
        
        view.add(subview: previewCell) { (v, p) in [
            v.topAnchor.constraint(equalTo: cvPreviewTitleLabel.bottomAnchor, constant: 5),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.2)
            ]}
    }
    
    override func setupUI() {
        super.setupUI()
        
        let titleLabel = BaseLabel(text: state.title, font: .regular, textColor: .Tint, numberOfLines: 1)
        navigationItem.titleView = titleLabel
    }
}

// MARK: - UICollectionView Delegate & DataSource Extension
/***************************************************************/
extension ChooseStateColorViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return all.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(ChooseStateColorCell.self, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cell as! ChooseStateColorCell
        
        cell.model = all[indexPath.row]
        
        if all[indexPath.row].color == state.color {
            cell.setAsSelected()
        } else {
            cell.setAsUnselected()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch state {
        case .Accepted:
            KeyManager.shared.acceptedColor = all[indexPath.row].color.toHexString()
        case .Applied:
            KeyManager.shared.appliedColor = all[indexPath.row].color.toHexString()
        case .Rejected:
            KeyManager.shared.rejectedColor = all[indexPath.row].color.toHexString()
        case .Interview:
            KeyManager.shared.interviewColor = all[indexPath.row].color.toHexString()
        default:
            break;
        }
        
               previewCell.injectPreviewData(state: state)
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 2, height: collectionView.frame.size.height / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
