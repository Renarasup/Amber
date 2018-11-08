//
//  EditNoteViewController.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 08.11.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

protocol EditNoteViewControllerDelegate: class {
    func didPressDone(_ editNoteViewController: EditNoteViewController, text: String)
}

class EditNoteViewController: BaseViewController {
    
    weak var delegate: EditNoteViewControllerDelegate?
    
    private let noteTextView = UITextView()
    private let textContainerView = UIView()
    
    init(text: String) {
        super.init(nibName: nil, bundle: nil)
        noteTextView.text = text
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textContainerView.backgroundColor = UIColor(rgb: 0xF3EFEF)
        textContainerView.layer.borderColor = UIColor(rgb: 0xE5E5E5).cgColor
        textContainerView.layer.borderWidth = 0.2
        textContainerView.layer.cornerRadius = 10
        
        noteTextView.backgroundColor = .clear
        noteTextView.font = .medium
        
        setupViewLayout()
    }
    
    private func setupViewLayout() {
        
        view.add(subview: textContainerView) { (v, p) in [
            v.topAnchor.constraint(equalTo: p.safeAreaLayoutGuide.topAnchor, constant: 25),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: 25),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor, constant: -25),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.3)
            ]}
        
        textContainerView.add(subview: noteTextView) { (v, p) in [
            v.topAnchor.constraint(equalTo: p.topAnchor, constant: 10),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: 10),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor, constant: -10),
            v.bottomAnchor.constraint(equalTo: p.bottomAnchor, constant: -10)
            ]}
    }
    
    override func setupUI() {
        super.setupUI()
        
        view.backgroundColor = .white
        
        // Set Done Bar Item
        let doneBarItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(onDonePressed))
        navigationItem.rightBarButtonItem = doneBarItem
        
        // Set back title
        navigationController?.navigationBar.topItem?.title = ""
        
        // Add Title Label
        let titleLabel = BaseLabel(text: "Edit Notes", font: .regular, textColor: .black, numberOfLines: 1)
        navigationItem.titleView = titleLabel
    }
    
    
    // MARK: - On Handlers
    /***************************************************************/
    
    
    @objc private func onDonePressed() {
        guard let text = noteTextView.text else { return }
        delegate?.didPressDone(self, text: text)
        dismiss(animated: true, completion: nil)
    }
}
