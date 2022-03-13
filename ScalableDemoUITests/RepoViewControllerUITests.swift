//
//  RepoViewControllerUITests.swift
//  ScalableDemoUITests
//
//  Created by Abdul Rahim on 14/03/22.
//

import XCTest

class RepoViewControllerUITests: XCTestCase {
    
    
    func test_tableview_exists() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        let tableView = XCUIApplication().tables.firstMatch
        XCTAssert(tableView.exists)
    }
    
    func test_table_view_scroll() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        XCUIApplication().tables.staticTexts["2200087-Serial-Protocol"].swipeUp()
        
    }

}
