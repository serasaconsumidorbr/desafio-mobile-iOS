//
//  MD5Tests.swift
//  MarvelCharactersTests
//
//  Created by Gabriel Beltrame Silva on 04/04/23.
//

import Foundation
import XCTest
@testable import MarvelCharacters

final class MD5Tests: XCTestCase {
    
    func testMD5HashGeneration() {
        XCTAssertEqual("this is a test string".MD5, "486eb65274adb86441072afa1e2289f3")
        XCTAssertEqual("this is another test string, but this time with numbers 123456".MD5, "6799b6019f13bd823b27c3a4d50eea22")
    }
}
