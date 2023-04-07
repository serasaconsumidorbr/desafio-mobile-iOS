//
//  APIKeysTests.swift
//  MarvelCharactersTests
//
//  Created by Gabriel Beltrame Silva on 04/04/23.
//

import Foundation
import XCTest
@testable import MarvelCharacters

final class APIKeysTests: XCTestCase {
    
    func testAPIKeysNotNilOrEmpty() {
        guard let apiKey = APIKeys.apiKey else {
            XCTFail("APIKey is nil")
            return
        }
        XCTAssertFalse(apiKey.isEmpty)
        
        guard let apiSecret = APIKeys.apiSecret else {
            XCTFail("APISecret is nil")
            return
        }
        XCTAssertFalse(apiSecret.isEmpty)
    }
}
