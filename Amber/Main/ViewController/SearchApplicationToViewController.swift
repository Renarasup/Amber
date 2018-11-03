//
//  SearchApplicationToViewController.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 03.11.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class SearchApplicationToViewController: BaseViewController {
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.searchController = searchController
        
        let dropDownBarItem = UIBarButtonItem(image: #imageLiteral(resourceName: "drop_down").withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(onDropDownPressed))
        dropDownBarItem.tintColor = .darkGray
        navigationItem.leftBarButtonItem = dropDownBarItem
    }
    
    override func setupUI() {
        super.setupUI()
        
        view.backgroundColor = .white
    }
    
    
    // MARK: - On Pressed Handlers
    /***************************************************************/
    
    @objc private func onDropDownPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: - Networking
    /***************************************************************/
    
//    //Write the getWeatherData method here:
//    func getWeatherData(url: String, parameters: [String: String]) {
//        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { (response) in
//            if response.result.isSuccess {
//                let weatherJSON: JSON = JSON(response.result.value!)
//                self.updateWeatherData(json: weatherJSON)
//            } else {
//                print("fail")
//            }
//        }
//    }
//
    
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
    
    
    //Write the updateWeatherData method here:
//    func updateWeatherData(json: JSON) {
//        if let tempResult = json["main"]["temp"].double {
//            weatherDataModel.temperature = Int(tempResult - 273.15)
//            weatherDataModel.city = json["name"].stringValue
//            weatherDataModel.condition = json["weather"][0]["id"].intValue
//            weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
//
//            updateUIWithWeatherData()
//        } else {
//            cityLabel.text = "Weather Unavailable"
//        }
//    }
}
