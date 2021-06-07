//
//  APIManagerTestCase.swift
//  marvel-charactersTests
//
//  Created by Paulo Atavila on 07/06/21.
//

import XCTest

@testable import marvel_characters

class APIManagerTestCase: XCTestCase {

    var sut: APIManager!
    
    override func setUp() {
        sut = APIManager(bundle: Bundle(for: type(of: self)))
    }

    override func tearDown() {
        sut = nil
    }
    
    func testFinalURL() {
        let url = sut.getFinalURL(to: "/test")
        XCTAssertEqual(url, "http://gateway.marvel.com/test")
    }
    
    func testFinalParameters() {
        let parameters = sut.getFinalParameters(parameters: nil)
        let hash = (String(Date.currentTimeStamp) + "private123" + "public123").asMD5Hash
        XCTAssertEqual(parameters["ts"], String(Date.currentTimeStamp))
        XCTAssertEqual(parameters["apikey"], "public123")
        XCTAssertEqual(parameters["hash"], hash)
    }
}
