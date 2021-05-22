//
//  Template.swift
//  ProjectDescriptionHelpers
//
//  Created by Lucas Paim on 22/05/21.
//

import ProjectDescription
let nameAttribute: Template.Attribute = .required("name")

let exampleContents = """
import Foundation

struct \(nameAttribute) { }
"""

let testContents = """
import XCTest

class \(nameAttribute)Tests: XCTestCase {
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

let testingContents = """
import \(nameAttribute)

public final class \(nameAttribute)Testing {
    public init() {}
}
"""

let projectDefition = """
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(name: "\(nameAttribute)", platform: .iOS, dependencies: [])
"""

let frameworkTemplate = Template(
    description: "Framework template",
    attributes: [
        nameAttribute,
    ],
    files: [
        .string(path: "Projects/\(nameAttribute)/Sources/\(nameAttribute).swift", contents: exampleContents),
        .string(path: "Projects/\(nameAttribute)/Tests/\(nameAttribute)Tests.swift", contents: testContents),
        .string(path: "Projects/\(nameAttribute)/Testing/\(nameAttribute)Testing.swift", contents: testingContents),
        .string(path: "Projects/\(nameAttribute)/Project.swift", contents: projectDefition),
    ]
)
