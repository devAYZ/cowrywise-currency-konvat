//
//  String + Extension.swift
//  cowrywise-currency-konvat
//
//  Created by Ayokunle Fatokimi on 02/04/2025.
//

import Foundation

extension String {
    func formattedAsCurrency() -> String {
        guard let number = Double(self) else { return self }  // Ensure it's a valid number
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: number)) ?? self
    }
}
