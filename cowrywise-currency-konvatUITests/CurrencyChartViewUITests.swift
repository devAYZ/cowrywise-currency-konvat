//
//  CurrencyChartViewUITests.swift
//  cowrywise-currency-konvatUITests
//
//  Created by Ayokunle Fatokimi on 01/04/2025.
//

import XCTest

final class CurrencyChartViewUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    func test_SegmentedControlExists() {
        let segmentControl = app.segmentedControls["timeSegmentControl"]
        XCTAssertTrue(segmentControl.exists, "Segmented control should be present")
    }
    
    func test_SegmentedControlNumberOfSegments() {
        let segmentControl = app.segmentedControls["timeSegmentControl"]
        
        // Get all buttons inside the segmented control (each segment is a button)
        let numberOfTabs = segmentControl.buttons
        XCTAssertEqual(numberOfTabs.count, 2, "Segmented control should have 2 segments")
    }
    
    func test_ChartViewExists() {
        let chartView = app.otherElements["chartView"]
        XCTAssertTrue(chartView.exists, "Chart view should be present")
    }
    
    func test_RateLabelExists() {
        let rateLabel = app.staticTexts["rateLabel"]
        XCTAssertTrue(rateLabel.exists, "Rate label should be present")
    }
    
    func test_SegmentControlChangesRateLabel() {
        let segmentControl = app.segmentedControls.firstMatch
        let rateLabel = app.staticTexts["rateLabel"]
        
        XCTAssertTrue(segmentControl.exists, "Segmented control should be present")
        XCTAssertTrue(rateLabel.exists, "Rate label should be present")
        
        // Verify initial value
        XCTAssertEqual(rateLabel.label, "1 EUR = 1,400")
        
        // Tap second segment
        segmentControl.buttons.element(boundBy: 1).tap()
        
        // Verify updated value
        XCTAssertEqual(rateLabel.label, "1 USD = 1,200")
    }
}
