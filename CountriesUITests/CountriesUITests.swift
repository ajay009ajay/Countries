//
//  CountriesUITests.swift
//  CountriesUITests
//
//  Created by user on 3/6/20.
//  Copyright © 2020 user. All rights reserved.
//

import XCTest

class CountriesUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app.launch()

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
//        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
     }
//
//    func testSeachCountryScreen()  {
//        XCTAssertTrue(app.tables["tableview.country.search"].exists, "TableView doesn't exist")
//    }

    
}
