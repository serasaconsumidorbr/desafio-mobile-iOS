//
//  CharactersListRouterTestCase.swift
//  marvel-charactersTests
//
//  Created by Paulo Atavila on 07/06/21.
//

import XCTest

@testable import marvel_characters

class CharactersListRouterTestCase: XCTestCase {

    var sut: CharactersListRouter!
    
    override func setUp() {
        sut = CharactersListRouter.charactersList(0)
    }

    override func tearDown() {
        sut = nil
    }
    
    func testPath() {
        XCTAssertEqual(sut.path, "/v1/public/characters")
    }
    
    func testParameters() {
        guard let parameters = sut.parameters else {
            XCTFail("No paramenters")
            return
        }
        XCTAssertEqual(parameters["offset"], "0")
    }
    
    func testHTTPMethod() {
        XCTAssertEqual(sut.method, .get)
    }
}
