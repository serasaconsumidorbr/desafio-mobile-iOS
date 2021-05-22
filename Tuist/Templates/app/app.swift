//
//  Template.swift
//  ProjectDescriptionHelpers
//
//  Created by Lucas Paim on 22/05/21.
//


import ProjectDescription

let appNameAttribute: Template.Attribute = .required("name")

let appDelegate = """
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
   
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
                        
        return true
    }
    
}
"""

let appTests = """
import XCTest

class \(appNameAttribute)Tests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}

"""



let appTemplate = Template(
    description: "App template",
    attributes: [
        appNameAttribute,
    ],
    files: [
        .string(path: "Projects/\(appNameAttribute)/Sources/AppDelegate.swift", contents: appDelegate),
        .string(path: "Projects/\(appNameAttribute)/Tests/\(appNameAttribute)Tests.swift", contents: appTests),
    ]
)
