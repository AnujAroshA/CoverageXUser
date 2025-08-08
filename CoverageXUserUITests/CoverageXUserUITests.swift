//
//  CoverageXUserUITests.swift
//  CoverageXUserUITests
//
//  Created by Arosha Piyadigama on 2025-08-07.
//

import XCTest

final class CoverageXUserUITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    func testNavigateToUserDetailAndCheckViews() throws {

        let firstCell = app.cells.firstMatch
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5), "List cell did not appear")

        firstCell.tap()

        let userImage = app.images["userImage"]
        let userFullName = app.staticTexts["userFullName"]
        let userEmail = app.staticTexts["userEmail"]
        let userPhone = app.staticTexts["userPhone"]

        XCTAssertTrue(userImage.waitForExistence(timeout: 5), "User image not found")
        XCTAssertTrue(userFullName.exists, "Full name label not found")
        XCTAssertTrue(userEmail.exists, "Email label not found")
        XCTAssertTrue(userPhone.exists, "Phone label not found")
    }
}
