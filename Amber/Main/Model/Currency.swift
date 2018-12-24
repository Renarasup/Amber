//
//  Currency.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 22.12.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

typealias CurrencyListResponse = [String: CurrencyValue]

struct CurrencyValue: Codable {
    let symbol, name, symbolNative: String
    let decimalDigits: Int
    let rounding: Double
    let code, namePlural: String
}

class CurrencyManager {
    
    var list: CurrencyListResponse?
    
    static let shared = CurrencyManager()
    
    func initialize() {
        loadCurrencyList { (response) in
            self.list = response
        }
    }
    
    private func loadCurrencyList(completion: (CurrencyListResponse) -> Void) {
        if let path = Bundle.main.path(forResource: "Common-Currency", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let currencies = try jsonDecoder.decode(CurrencyListResponse.self, from: data)
                completion(currencies)
            } catch let err{
                print(err)
            }
        }
    }
}
