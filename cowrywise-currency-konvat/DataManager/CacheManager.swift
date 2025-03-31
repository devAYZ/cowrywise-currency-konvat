//
//  CacheManager.swift
//  cowrywise-currency-konvat
//
//  Created by Ayokunle Fatokimi on 30/03/2025.
//

import Foundation
import RealmSwift

protocol CacheManagerProtocol {
    func saveObject<T: Object>(_ object: T?)
    func retrieveObject<T: Object>(_ type: T.Type) -> T?
}

class RealmManager: CacheManagerProtocol {
    static let shared = RealmManager()
    
    var realmDB: Realm
    
    init() {
        realmDB = try! Realm()
    }
    
    func saveObject<T: Object>(_ object: T?) {
        guard let object = object else { return }
        do {
            try realmDB.write {
                realmDB.add(object, update: .modified)
            }
            
        } catch {
            print("Error saving object: \(error)")
        }
    }
    
    func retrieveObject<T: Object>(_ type: T.Type) -> T? {
        return realmDB.objects(type).first
    }
}
