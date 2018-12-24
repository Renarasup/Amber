//
//  RealmHelper.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 08.11.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    private var database: Realm
    static let shared = RealmManager()
    
    private init() {
        database = try! Realm()
    }
    func getDataFromDB() -> Results<Object> {
        let results: Results<Object> = database.objects(Object.self)
        return results
    }
    func addData(object: Object)   {
        try! database.write {
            database.add(object, update: true)
            print("Added new object")
        }
    }
    func deleteAllFromDatabase()  {
        try! database.write {
            database.deleteAll()
        }
    }
    func deleteFromDb(object: Object)   {
        try! database.write {
            database.delete(object)
        }
    }
}
