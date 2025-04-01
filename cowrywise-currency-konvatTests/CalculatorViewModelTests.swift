//
//  CalculatorViewModelTests.swift
//  cowrywise-currency-konvatTests
//
//  Created by Ayokunle Fatokimi on 01/04/2025.
//

import XCTest
import Foundation
@testable import cowrywise_currency_konvat

final class CalculatorViewModelTests: XCTestCase {
    
    // MARK: Properties
    var sut: CalculatorViewModel!
    var mockViewDelegate: MockCalculatorViewDelegate!
    var mockNetworkClass: MockNetworkService!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        setupSUTAPIFlow(apiFlow: nil)
    }
    
    override func tearDown() {
        mockViewDelegate = nil
        mockNetworkClass = nil
        sut = nil
        super.tearDown()
    }
    
    private func setupSUTAPIFlow(apiFlow: MockNetworkServiceFlow?) {
        mockNetworkClass = MockNetworkService(apiFlow: apiFlow)
        sut = CalculatorViewModel(networkClass: mockNetworkClass)
        mockViewDelegate = MockCalculatorViewDelegate()
        sut.attachView(view: mockViewDelegate)
    }
    
    func test_fetchSymbolsList_Success() {
        setupSUTAPIFlow(apiFlow: .successFetchSymbolsList)
        let exp = expectation(description: "Wait for fetch completion")
        sut.getCurrencyList()
        
        XCTAssertEqual(mockViewDelegate.receivedSymbols?.count, 5)
        exp.fulfill()
        
        waitForExpectations(timeout: 0.1)
    }
    
    func test_fetchSymbolsList_Fail() {
        setupSUTAPIFlow(apiFlow: .failFetchSymbolsList)
        let exp = expectation(description: "Wait for fetch completion")
        sut.getCurrencyList()
        
        XCTAssertNotNil(mockViewDelegate.receivedError)
        XCTAssert(mockViewDelegate.receivedError?.contains("Unit Test Error response") ?? false)
        exp.fulfill()
        
        waitForExpectations(timeout: 0.1)
    }
}
