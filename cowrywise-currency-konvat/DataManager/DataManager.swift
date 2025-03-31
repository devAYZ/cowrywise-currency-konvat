//
//  DataManager.swift
//  cowrywise-currency-konvat
//
//  Created by Ayokunle Fatokimi on 28/03/2025.
//

import Foundation
import RealmSwift

class DataManager: Object {
    static let shared = DataManager()
    
    override static func primaryKey() -> String? {
        return "symbolsListStringData"
    }
    //@Persisted(primaryKey: true) var _id: String = UUID().uuidString

    
    @objc dynamic var symbolsListStringData: String = "" // Store as JSON string
    var symbolsListData: SymbolsList? {
        get {
            guard let data = symbolsListStringData.data(using: .utf8) else { return nil }
            return try? JSONDecoder().decode(SymbolsList.self, from: data)
        }
        set {
            if let newValue = newValue,
               let jsonData = try? JSONEncoder().encode(newValue),
               let jsonString = String(data: jsonData, encoding: .utf8) {
                symbolsListStringData = jsonString
            }
        }
    }
}
