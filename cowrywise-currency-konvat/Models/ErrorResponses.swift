//
//  ErrorResponses.swift
//  cowrywise-currency-konvat
//
//  Created by Ayokunle Fatokimi on 28/03/2025.
//

import Foundation

struct ErrorResponse: Codable {
    var code: Int?
    var type: String?
    var info: String?
}
