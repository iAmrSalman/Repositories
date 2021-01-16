//
//  RepositoriesUITests.swift
//  RepositoriesUITests
//
//  Created by Amr Salman on 1/16/21.
//

import XCTest

class RepositoriesUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearch() throws {
        let app = XCUIApplication()
        app.launch()
        app.searchFields.firstMatch.tap()
        app.searchFields.firstMatch.typeText("iAmrSalman/StorageManager")
        expectation(for: NSPredicate(format: "count >= 1"), evaluatedWith: app.tables.firstMatch.cells, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)

        XCTAssertTrue(app.tables.firstMatch.cells.count >= 1, "This should be at least one")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
