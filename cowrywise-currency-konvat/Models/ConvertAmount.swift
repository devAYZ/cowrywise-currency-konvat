//
//  ConvertAmount.swift
//  cowrywise-currency-konvat
//
//  Created by Ayokunle Fatokimi on 31/03/2025.
//

import Foundation

struct ConvertAmountResponse: Codable {
    var info: Info?
    var date: String?
    var success: Bool?
    var query: Query?
    var historical: String?
    var result: Double?
    var error: ErrorResponse?
}

struct Info: Codable {
    var timestamp: Int?
    var rate: Double?
}

struct Query: Codable {
    var to: String?
    var amount: Int?
    var from: String?
}
