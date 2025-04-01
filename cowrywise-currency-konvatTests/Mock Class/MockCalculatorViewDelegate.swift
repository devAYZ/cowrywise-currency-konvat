//
//  MockCalculatorViewDelegate.swift
//  cowrywise-currency-konvatTests
//
//  Created by Ayokunle Fatokimi on 01/04/2025.
//

import Foundation
@testable import cowrywise_currency_konvat

class MockCalculatorViewDelegate: CalculatorViewDelegate {
    var loaderShown = false
    var receivedError: String?
    var receivedSymbols: [String: String]?
    var receivedConversion: ConvertAmountResponse?
    
    func handleLoader(show: Bool) {
        loaderShown = show
    }
    
    func handleError(message: String?) {
        receivedError = message
    }
    
    func handleSuccess(sysmbols: [String: String]?) {
        receivedSymbols = sysmbols
    }
    
    func handleSuccess(coversion: ConvertAmountResponse) {
        receivedConversion = coversion
    }
}
