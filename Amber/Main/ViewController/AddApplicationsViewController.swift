//
//  AddApplicationsViewController.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 02.11.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit
import RealmSwift

class AddApplicationsViewController: BaseViewController {
    
    // Instance Variables
    var coordinator: ApplicationsCoordinator?
    private let circleHeight: CGFloat = UIScreen.main.bounds.width * 0.05
    private let allInformation = Application.Information.all
    private var application: Application?
    
    // UI Views
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    private let circleView = UIView()
    private let lineView = UIView()
    private let addImageView = UIImageView()
    private let addNoteButton = UIButton()
    private let textContainerView = UIView()
    private let removeEditNoteButton = UIButton()
    private let noteTextView = UITextView()
    
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
    
    // MARK: - Setup Core Components & Delegations
    /***************************************************************/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(InformationCell.self)
        
        addImageView.image = #imageLiteral(resourceName: "add-plus").withRenderingMode(.alwaysTemplate)
        addImageView.tintColor = .white
        
        lineView.backgroundColor = UIColor(rgb: 0x3498db)
        circleView.backgroundColor = UIColor(rgb: 0x3498db)
        
        addNoteButton.setTitle("Add Notes", for: .normal)
        addNoteButton.setTitleColor(.lightGray, for: .normal)
        addNoteButton.titleLabel?.font = .regular
        addNoteButton.addTarget(self, action: #selector(onAddNotesPressed), for: .touchUpInside)
        
        removeEditNoteButton.setTitle("Remove Notes", for: .normal)
        removeEditNoteButton.setTitleColor(.white, for: .normal)
        removeEditNoteButton.titleLabel?.font = .regular
        removeEditNoteButton.backgroundColor = UIColor(rgb: 0xe74c3c)
        removeEditNoteButton.layer.cornerRadius = 7
        removeEditNoteButton.addTarget(self, action: #selector(onRemoveEditNotesPressed), for: .touchUpInside)
        
        circleView.isUserInteractionEnabled = true
        circleView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onAddNotesPressed)))
        
        textContainerView.backgroundColor = UIColor(rgb: 0xF3EFEF)
        textContainerView.layer.borderColor = UIColor(rgb: 0xE5E5E5).cgColor
        textContainerView.layer.borderWidth = 0.2
        textContainerView.layer.cornerRadius = 10
        
        if let application = application {
            if let note = application.note {
                noteTextView.text = note
                textContainerView.alpha = 1
            } else {
                textContainerView.alpha = 0
            }
        } else {
            textContainerView.alpha = 0
        }
        
        noteTextView.backgroundColor = .clear
        noteTextView.font = .medium
        
        setupLayoutViews()
    }
    
    private func setupLayoutViews() {
        view.add(subview: collectionView) { (v, p) in [
            v.topAnchor.constraint(equalTo: p.safeAreaLayoutGuide.topAnchor),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.5)
            ]}
        
        view.add(subview: circleView) { (v, p) in [
            v.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 50),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: 30),
            v.heightAnchor.constraint(equalToConstant: circleHeight),
            v.widthAnchor.constraint(equalToConstant: circleHeight)
            ]}
        
        view.add(subview: lineView) { (v, p) in [
            v.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            v.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            v.bottomAnchor.constraint(equalTo: circleView.centerYAnchor),
            v.widthAnchor.constraint(equalToConstant: 3)
            ]}
        
        view.add(subview: addImageView) { (v, p) in [
            v.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
            v.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            v.heightAnchor.constraint(equalTo: circleView.heightAnchor, multiplier: 0.7),
            v.widthAnchor.constraint(equalTo: circleView.heightAnchor, multiplier: 0.7)
            ]}
        
        view.add(subview: addNoteButton) { (v, p) in [
            v.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
            v.leadingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: 15),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.05),
            v.widthAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.2)
            ]}
        
        view.add(subview: textContainerView) { (v, p) in [
            v.topAnchor.constraint(equalTo: circleView.topAnchor),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: 25),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor, constant: -25),
            v.bottomAnchor.constraint(equalTo: p.safeAreaLayoutGuide.bottomAnchor, constant: -25)
            ]}
        
        textContainerView.add(subview: removeEditNoteButton) { (v, p) in [
            v.bottomAnchor.constraint(equalTo: p.bottomAnchor, constant: -10),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor, constant: -10),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.15),
            v.widthAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.4)
            ]}
        
        textContainerView.add(subview: noteTextView) { (v, p) in [
            v.topAnchor.constraint(equalTo: p.topAnchor, constant: 10),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: 10),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor, constant: -10),
            v.bottomAnchor.constraint(equalTo: removeEditNoteButton.topAnchor, constant: -10)
            ]}
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        circleView.layer.cornerRadius = circleView.frame.size.width / 2
    }
    
    // **** Basic UI Setup For The ViewController ****
    override func setupUI() {
        super.setupUI()
        
        view.backgroundColor = .white
        
        // Save Bar Item
        let saveBarItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(onSavePressed))
        navigationItem.rightBarButtonItem = saveBarItem
        
        // Set back title
        navigationController?.navigationBar.topItem?.title = ""
    }
    
    
    // MARK: - On Handlers
    /***************************************************************/
    
    @objc private func onSavePressed() {
        setCRUD()
    }
    
    @objc private func onAddNotesPressed() {
//        coordinator?.showEditNoteScreen(text: noteTextView.text ?? "", addApplicationsVC: self)
    }
    
    @objc private func onRemoveEditNotesPressed() {
        noteTextView.text = ""
        deAnimateTextContainer()
    }
    
    // MARK: - UI Animations
    /***************************************************************/
    
    private func animateTextContainer() {
        UIView.animate(withDuration: 0.25) {
            self.textContainerView.alpha = 1
        }
    }
    
    private func deAnimateTextContainer() {
        UIView.animate(withDuration: 0.25) {
            self.textContainerView.alpha = 0
        }
    }
    
    // MARK: - Realm CRUD
    /***************************************************************/
    
    private func setCRUD() {
        let application = Application()
        var boolsArray = [Bool]()
        for index in allInformation.enumerated() {
            if let cvCell = collectionView.cellForItem(at: IndexPath(item: index.offset, section: 0)) as? InformationCell {
                boolsArray.append(cvCell.isFilled)
                guard let text = cvCell.textField.text else { return }
                
                switch index.element {
                case .ApplicationTo:
                    if let searchApplication = cvCell.searchApplication {
                        application.applicationToTitle = text
                        
                        if self.application?.imageLink ?? "" != searchApplication.logoPath {
                            application.imageLink = searchApplication.logoPath
                        } else {
                            application.imageLink = self.application?.imageLink
                        }
                    } else {
                        application.applicationToTitle = text
                        application.imageLink = self.application?.imageLink
                    }
                case .Date:
                    application.sentDate = text
                case .Salary:
                    application.salary = Double(text) ?? 0
                case .Job:
                    application.jobTitle = text
                case .State:
                    guard let state = cvCell.state else { return }
                    application.state = state.rawValue
                case .ZipCode:
                    application.zipCode = text
                default:
                    break
                }
            }
        }
        
        if !noteTextView.text.isEmpty {
            application.note = noteTextView.text
        }

        if let savedApplication = self.application {
            let imageLink = application.imageLink ?? ""
            do {
                let realm = try Realm()
                try realm.write {
                    savedApplication.applicationToTitle = application.applicationToTitle
                    savedApplication.jobTitle = application.jobTitle
                    savedApplication.salary = application.salary
                    savedApplication.state = application.state
                    savedApplication.sentDate = application.sentDate
                    savedApplication.zipCode = application.zipCode
                    savedApplication.note = application.note
                    savedApplication.imageLink = imageLink
                }
                
                navigationController?.popViewController(animated: true)
            } catch let error as NSError {
                
                // handle error
            
            }
        } else {

            // It's a new application
            if !boolsArray.contains(false) {
                do {
                    let realm = try Realm()
                    try realm.write {
                        realm.add(application)
                    }
                    
                    navigationController?.popViewController(animated: true)
                } catch let error as NSError {
                    
                    // handle error
                }
                print(true)
            } else {
                // alert that everything should be filled out
                print(false)
            }
        }
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
        
        if let application = application {
            cell.application = application
        }
        
        cell.model = information
        
        if information == .ApplicationTo || information == .State {
            cell.textField.isUserInteractionEnabled = false
        }
    
        if indexPath.row != 0 {
            cell.addLineToTop()
        }
        
        cell.addLineToBottom()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let information = allInformation[indexPath.row]
        
        if information == .ApplicationTo {
//            coordinator?.showSearchApplicationsToScreen(addApplicationsVC: self)
        }
        
        if information == .State {
            coordinator?.showChooseStateScreen(addApplicationsVC: self)
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
        guard let index = allInformation.firstIndex(of: .ApplicationTo) else { return }

        if let cvCell = collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? InformationCell {
            let tableViewCell = cell as! SearchApplicationCell

            cvCell.addSearchApplication(tableViewCell.model)
            cvCell.addLogoImage(tableViewCell.getLogoImage())
            cvCell.isFilled = true
        }
    }
}

extension AddApplicationsViewController: EditNoteViewControllerDelegate {
    
    func didPressDone(_ editNoteViewController: EditNoteViewController, text: String) {
        if !text.isEmpty {
            noteTextView.text = text
            animateTextContainer()
        }
    }
}

extension AddApplicationsViewController: ChooseStateViewControllerDelegate {
    
    func didChooseState(_ chooseStateViewController: ChooseStateViewController, state: Application.StateType) {
        guard let index = allInformation.firstIndex(of: .State) else { return }
        
        if let cvCell = collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? InformationCell {
            cvCell.addStateView(state)
            cvCell.isFilled = true
        }
    }
}
