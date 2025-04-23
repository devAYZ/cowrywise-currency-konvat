//
//  DataManager.swift
//  cowrywise-currency-konvat
//
//  Created by Ayokunle Fatokimi on 28/03/2025.
//

import Foundation
import RealmSwift
import SwiftyJSON

class DataManager: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id = "symbolsListStringData"
    @Persisted var symbolsListStringData: String = ""
    
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
