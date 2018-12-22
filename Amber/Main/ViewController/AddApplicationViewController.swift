//
//  AddApplicationViewController.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 21.12.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class AddApplicationViewController: BaseViewController {
    
    // Instance Variables
    var coordinator: ApplicationsCoordinator?
    
    private var application: Application?
    private let allInformation = Application.Information.all
    
    
    // UI Views
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    private let noteContainerView = UIView()
    private let noteAddImageView = UIImageView()
    private let noteLabel = BaseLabel(text: "Add Note", font: .regular, textColor: .black, numberOfLines: 1)
    
    private let noteTextView = UITextView()
    private let textContainerView = UIView()
    private let removeEditNoteButton = UIButton()
    
    private var offsetY: CGFloat = 0

    
    // MARK: - Setup Core Components & Delegations
    /***************************************************************/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AddApplicationCell.self)
        collectionView.bounces = false
        collectionView.backgroundColor = .white
        
        noteContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onAddNotesPressed)))
        
        noteTextView.autocorrectionType = .no
        
        let doneToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        doneToolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(onDoneToolBarTapped))]
        doneToolbar.sizeToFit()
        doneToolbar.tintColor = .Highlight
        noteTextView.inputAccessoryView = doneToolbar
        
        setupViewsLayout()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        noteContainerView.layer.cornerRadius = noteContainerView.frame.height / 2
    }
    
    private func setupViewsLayout() {
        view.add(subview: collectionView) { (v, p) in [
            v.topAnchor.constraint(equalTo: p.safeAreaLayoutGuide.topAnchor, constant: Constants.padding),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.55)
            ]}
        
//        view.add(subview: noteContainerView) { (v, p) in [
//            v.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: Constants.padding),
//            v.centerXAnchor.constraint(equalTo: p.centerXAnchor),
//            v.widthAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.15),
//            v.heightAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.15)
//            ]}
//
//        noteContainerView.add(subview: noteAddImageView) { (v, p) in [
//            v.centerYAnchor.constraint(equalTo: p.centerYAnchor),
//            v.centerXAnchor.constraint(equalTo: p.centerXAnchor),
//            v.widthAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.4),
//            v.heightAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.4)
//            ]}
//
//        view.add(subview: noteLabel) { (v, p) in [
//            v.topAnchor.constraint(equalTo: noteContainerView.bottomAnchor, constant: Constants.padding - 5),
//            v.centerXAnchor.constraint(equalTo: p.centerXAnchor)
//            ]}
        
        view.add(subview: textContainerView) { (v, p) in [
            v.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: Constants.padding),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: Constants.padding),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor, constant: -Constants.padding),
            v.bottomAnchor.constraint(equalTo: p.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.padding - 5)
            ]}
        
        textContainerView.add(subview: removeEditNoteButton) { (v, p) in [
            v.bottomAnchor.constraint(equalTo: p.bottomAnchor, constant: -Constants.padding),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor, constant: -Constants.padding),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.15),
            v.widthAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.4)
            ]}
        
        textContainerView.add(subview: noteTextView) { (v, p) in [
            v.topAnchor.constraint(equalTo: p.topAnchor, constant: Constants.padding),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: Constants.padding),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor, constant: -Constants.padding),
            v.bottomAnchor.constraint(equalTo: removeEditNoteButton.topAnchor, constant: -Constants.padding)
            ]}
    }
    
    // **** Basic UI Setup For The ViewController ****
    
    override func setupUI() {
        super.setupUI()
        
        view.backgroundColor = .white
        
        // Notes
        textContainerView.backgroundColor = UIColor(rgb: 0xF3EFEF)
        textContainerView.layer.borderColor = UIColor(rgb: 0xE5E5E5).cgColor
        textContainerView.layer.borderWidth = 0.2
        textContainerView.layer.cornerRadius = Constants.bigCornerRadius
        textContainerView.addShadows()
        
        noteTextView.backgroundColor = .clear
        noteTextView.font = .medium
        
        removeEditNoteButton.setTitle("Remove Notes", for: .normal)
        removeEditNoteButton.setTitleColor(.white, for: .normal)
        removeEditNoteButton.titleLabel?.font = .regular
        removeEditNoteButton.backgroundColor = .Highlight
        removeEditNoteButton.layer.cornerRadius = 7
        removeEditNoteButton.addTarget(self, action: #selector(onRemoveEditNotesPressed), for: .touchUpInside)
        
        // Save Bar Item
        let saveBarItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(onSavePressed))
        navigationItem.rightBarButtonItem = saveBarItem
        
        // Set back title
        navigationController?.navigationBar.topItem?.title = ""
        
        // Uses the same color as applicationHeader
        noteContainerView.backgroundColor = UIColor.ApplicationHeader
        noteAddImageView.image = #imageLiteral(resourceName: "add-plus").withRenderingMode(.alwaysTemplate)
        noteAddImageView.tintColor = .white
    }
    
    // **** Initializers ****
    
    convenience init(application: Application) {
        self.init(nibName: nil, bundle: nil)
        
        self.application = application
        
        // Add Title Label
        let titleLabel = BaseLabel(text: "Manage Application", font: .regular, textColor: .black, numberOfLines: 1)
        navigationItem.titleView = titleLabel
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        
        // Add Title Label
        let titleLabel = BaseLabel(text: "Add Application", font: .regular, textColor: .black, numberOfLines: 1)
        navigationItem.titleView = titleLabel
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - On Handlers
    /***************************************************************/
    
    @objc private func onSavePressed() {
        setCRUD()
    }
    
    @objc private func onAddNotesPressed() {
        coordinator?.showEditNoteScreen(text: "", addApplicationsVC: self)
    }
    
    @objc private func onRemoveEditNotesPressed() {
//        noteTextView.text = ""
//        deAnimateTextContainer()
    }
    
    @objc private func onDoneToolBarTapped() {
        view.endEditing(true)
    }
    
    
    // MARK: - Realm CRUD
    /***************************************************************/
    
    private func setCRUD() {
        
    }
}


// MARK: - UICollectionView Delegate & DataSource Extension
/***************************************************************/
extension AddApplicationViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allInformation.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(AddApplicationCell.self, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cell as! AddApplicationCell
        
        cell.model = allInformation[indexPath.row]
        
        if indexPath.row == 0 {
            cell.setSearchCompanyMode()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            coordinator?.showSearchApplicationsToScreen(addApplicationsVC: self)
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

extension AddApplicationViewController: SearchApplicationToViewControllerDelegate {
    func didSelect(_ cell: UITableViewCell, searchApplication: SearchApplication) {
        guard let index = allInformation.firstIndex(of: .ApplicationTo) else { return }
        
        if let cvCell = collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? AddApplicationCell {
            cvCell.update(text: searchApplication.name, imageLink: searchApplication.logoPath)
        }
    }
}

extension AddApplicationViewController: EditNoteViewControllerDelegate {
    func didPressDone(_ editNoteViewController: EditNoteViewController, text: String) {
        
    }
}
