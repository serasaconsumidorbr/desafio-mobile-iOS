//
//  MarvelsUITestsLaunchTests.swift
//  MarvelsUITests
//
//  Created by Moacir Ezequiel Lamego on 23/05/2022.
//

import XCTest

class MarvelsUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
    
    func testSample() {
        XCUIApplication().tables.cells.containing(.staticText, identifier:"Sleeper").staticTexts["Sem detalhes"].swipeUp()
        
                                                
    }
}
