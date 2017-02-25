//
//  olxUITests.swift
//  olxUITests
//
//  Created by Anjani on 2/24/17.
//  Copyright © 2017 do. All rights reserved.
//

import XCTest

class olxUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSearchBar() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        XCTAssert(tablesQuery.searchFields["Search"].exists == true)
    }
    
    func testCancelButton() {
        
        let tablesQuery = XCUIApplication().tables
        tablesQuery.searchFields["Search"].tap()
        XCTAssert(tablesQuery.buttons["Cancel"].exists == true)
    }
    
    func testSearchResults() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.searchFields["Search"].tap()
        
        tablesQuery.searchFields["Search"].typeText("iphone")
        sleep(6)
        tablesQuery.buttons["Cancel"].tap()
        let count = tablesQuery.cells.count
        XCTAssert(count > 0)
    }
    
    func testDetailsPage() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.searchFields["Search"].tap()
        
        tablesQuery.searchFields["Search"].typeText("iphone")
        sleep(6)
        tablesQuery.buttons["Cancel"].tap()
        tablesQuery.cells.element(boundBy: 0).tap()
        
        XCTAssert(app.navigationBars["Details"].staticTexts["Details"].exists == true)
        
    }
    
    func testLandScapeOrientation()  {
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.searchFields["Search"].tap()
        
        tablesQuery.searchFields["Search"].typeText("iphone")
        sleep(6)
        tablesQuery.buttons["Cancel"].tap()
        XCUIDevice.shared().orientation = .landscapeLeft
        
        let count = tablesQuery.cells.count
        XCTAssert(count > 0)
        
    }
}
