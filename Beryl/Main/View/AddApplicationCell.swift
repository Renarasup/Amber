//
//  AddApplicationCell.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 21.12.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit
import Kingfisher

class AddApplicationCell: UICollectionViewCell {
    
    func setInput(application: Application, model: Application.Information) {
        
        setInput(model: model)
        
        switch model {
        case .ApplicationTo:
            textField.text = application.applicationToTitle
            
            guard
                let imageLink = application.imageLink,
                let imageURL = URL(string: imageLink)
                else { return }
            logoPath = imageLink
            imageView.kf.setImage(with: imageURL)

        case .Job:
            textField.text = application.jobTitle
        case .Salary:
            salaryPayCycle = application.salaryPayCycle
            salaryCurrencyCode = application.salaryCurrencyCode
            salaryCurrencySymbol = application.salaryCurrencySymbol
            
            salaryTextField.text = "\(application.salaryPayCycle) in \(application.salaryCurrencyCode) \((application.salaryCurrencySymbol))"
            textField.text = application.salaryWithoutDecimal
            textField.keyboardType = .numberPad

            self.selectedIndex = self.allCurrencies.firstIndex(where: { (currency) -> Bool in
                if currency == "\(application.salaryCurrencyCode) (\(application.salaryCurrencySymbol))" {
                    return true
                }
                return false
            }) ?? 0
            
            pickerView.selectRow(salaryPayCycle == "Monthly" ? 0 : 1, inComponent: 0, animated: true)
            pickerView.selectRow(selectedIndex, inComponent: 1, animated: true)

        case .State:
            state = application.stateEnum
            textField.text = application.stateEnum.title
            addStateView(application.stateEnum)
            bringSubviewToFront(textField)
        case .Date:
            textField.text = application.sentDate
        default:
            break
        }
    }
    
    func setInput(model: Application.Information) {
        
        self.model = model
        textField.attributedPlaceholder = NSAttributedString(string: model.title, attributes: textFieldPlaceholderAttributes as [NSAttributedString.Key : Any])
        
        if model == .Salary {
            addSalaryTextField()
            setCurrencies()
            
            textField.keyboardType = .numberPad
        }
        if model == .Date {
            let datePickerView: UIDatePicker = UIDatePicker()
            datePickerView.datePickerMode = UIDatePicker.Mode.date
            
            datePickerView.addTarget(self, action: #selector(onDatePickerValueChanged(_:)), for: UIControl.Event.valueChanged)
            
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
            
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "dd.MM.yyyy"
            
            if let date = dateFormatterGet.date(from: "\(Date())") {
                textField.text = dateFormatterPrint.string(from: date)
            } else {
                print("There was an error decoding the string")
            }
            
            textField.inputView = datePickerView
        }
        if model == .State {
            pickerDataSource.append(Application.StateType.dataSource)
            let pickerView = UIPickerView()
            
            pickerView.delegate = self
            pickerView.dataSource = self
            textField.inputView = pickerView
            addStateView()
        }
    }
    
    var allCurrencies = [String]()
    var allCodes = [String]()
    var allSymbols = [String]()
    var pickerDataSource = [[String]]()
    
    var selectedIndex = 0
    var logoPath: String?
    var state: Application.StateType?
    var isFilled: Bool {
        if textField.text == "" {
            return false
        }
        return true
    }
    
    let textField = UITextField()
    let salaryTextField = UITextField()
    let pickerView = UIPickerView()
    
    var salaryCurrencySymbol = ""
    var salaryPayCycle = ""
    var salaryCurrencyCode = ""

    private var model: Application.Information!
    private let containerView = UIView()
    private let imageView = UIImageView()
    private let stateContainerView = UIView()
    private let stateTitleLabel = BaseLabel(font: .regular, textColor: .white, numberOfLines: 1)

    private let textFieldPlaceholderAttributes = [
        NSAttributedString.Key.foregroundColor: UIColor.Placeholder,
        NSAttributedString.Key.font : UIFont.bold
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        containerView.backgroundColor = .AddApplicationCell
        containerView.layer.cornerRadius = Constants.bigCornerRadius
        
        textField.textColor = .Tint
        textField.autocorrectionType = .no
        
        setupViewsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.layer.cornerRadius = (containerView.frame.height * 0.7) / 2
        imageView.clipsToBounds = true
    }
    
    private func setupViewsLayout() {
        add(subview: containerView) { (v, p) in [
            v.topAnchor.constraint(equalTo: p.topAnchor, constant: 5),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: Constants.padding),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor, constant: -Constants.padding),
            v.bottomAnchor.constraint(equalTo: p.bottomAnchor, constant: -Constants.padding + 5)
            ]}

        containerView.add(subview: textField) { (v, p) in [
            v.centerYAnchor.constraint(equalTo: p.centerYAnchor),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: Constants.padding),
            v.widthAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.7),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.7)
            ]}
        
        addLogoImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func onDoneToolBarTapped() {
        endEditing(true)
    }
    
    @objc private func onDatePickerValueChanged(_ sender: UIDatePicker) {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd.MM.yyyy"
        
        if let date = dateFormatterGet.date(from: "\(sender.date)") {
            textField.text = dateFormatterPrint.string(from: date)
        } else {
            print("There was an error decoding the string")
        }
    }
    
    func update(text: String) {
        
    }
    
    func update(text: String, imageLink: String) {
        
        textField.text = text
        
        guard let url = URL(string: imageLink) else {
            return
        }
        
        logoPath = imageLink
        imageView.kf.setImage(with: url)
    }
    
    private func setCurrencies() {
        var allCurrencies = [String]()
        var allSymbols = [String]()
        var allCodes = [String]()
        
        if let response = CurrencyManager.shared.list {
            for currency in response.sorted(by: { $0.0 < $1.0 }) {
                let symbol = currency.value.symbol
                let code = currency.value.code
                
                allCurrencies.append("\(code) (\(symbol))")
                allSymbols.append(symbol)
                allCodes.append(code)
            }
            
            self.allCodes = allCodes
            self.allSymbols = allSymbols
            self.allCurrencies = allCurrencies
            
            self.selectedIndex = self.allCurrencies.firstIndex(where: { (currency) -> Bool in
                if currency == KeyManager.shared.defaultCurrency {
                    return true
                }
                return false
            }) ?? 0
            
            pickerDataSource.append(SalaryPicker.dataSource.sorted())
            pickerDataSource.append(allCurrencies)
            
            pickerView.delegate = self
            pickerView.dataSource = self
            
            pickerView.selectRow(1, inComponent: 0, animated: true)
            pickerView.selectRow(selectedIndex, inComponent: 1, animated: true)
            
            let splitCurrency = KeyManager.shared.defaultCurrency.components(separatedBy: " ")
            salaryCurrencySymbol = splitCurrency[1].replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "")
            salaryPayCycle = "Yearly"
            salaryCurrencyCode = splitCurrency[0]
            
            salaryTextField.inputView = pickerView
        }
    }
    private func addSalaryTextField() {
        salaryTextField.text = "Yearly in \(KeyManager.shared.defaultCurrency)"
        salaryTextField.textAlignment = .right
        salaryTextField.textColor = .lightGray
        
        textField.removeFromSuperview()
        
        containerView.add(subview: textField) { (v, p) in [
            v.centerYAnchor.constraint(equalTo: p.centerYAnchor),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: Constants.padding),
            v.widthAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.5),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.7)
            ]}
        
        containerView.add(subview: salaryTextField) { (v, p) in [
            v.centerYAnchor.constraint(equalTo: p.centerYAnchor),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor, constant: -Constants.padding),
            v.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: Constants.padding),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.7)
            ]}
    }
    
    private func addLogoImageView() {
        containerView.add(subview: imageView) { (v, p) in [
            v.centerYAnchor.constraint(equalTo: p.centerYAnchor),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor, constant: -Constants.padding),
            v.widthAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.7),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.7)
            ]}
    }
    
    private func addStateView(_ state: Application.StateType) {
        addStateView()
        stateContainerView.backgroundColor = state.color
        stateTitleLabel.text = state.title
    }
    
    private func addStateView() {
        
        stateContainerView.layer.cornerRadius = Constants.smallCornerRadius
        stateContainerView.backgroundColor = Application.StateType.Applied.color
        stateTitleLabel.text = Application.StateType.Applied.title
        textField.text = Application.StateType.Applied.title
        textField.textColor = .clear
        
        containerView.add(subview: stateContainerView) { (v, p) in [
            v.centerYAnchor.constraint(equalTo: p.centerYAnchor),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: Constants.padding),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.4),
            v.widthAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.3)
            ]}
        
        stateContainerView.add(subview: stateTitleLabel) { (v, p) in [
            v.centerXAnchor.constraint(equalTo: p.centerXAnchor),
            v.centerYAnchor.constraint(equalTo: p.centerYAnchor)
            ]}
        
        stateContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onStateContainerTapped)))

    }
    
    @objc private func onStateContainerTapped() {
        textField.becomeFirstResponder()
    }
    
    func disableUserInteraction() {
        textField.isUserInteractionEnabled = false
    }
}


extension AddApplicationCell: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let model = model {
            if model == .Salary {
                salaryCurrencySymbol = allSymbols[pickerView.selectedRow(inComponent: 1)]
                salaryCurrencyCode = allCodes[pickerView.selectedRow(inComponent: 1)]
                salaryPayCycle = pickerDataSource[0][pickerView.selectedRow(inComponent: 0)]
                
                salaryTextField.text = "\(pickerDataSource[0][pickerView.selectedRow(inComponent: 0)]) in \(pickerDataSource[1][pickerView.selectedRow(inComponent: 1)])"
            }
            if model == .State {
                stateTitleLabel.text = pickerDataSource[component][row]
                textField.text = pickerDataSource[component][row]
                state = Application.StateType.all[row]
                UIView.animate(withDuration: 0.25) {
                    self.stateContainerView.backgroundColor = Application.StateType.all[row].color
                }
            }
        }
    }
}
