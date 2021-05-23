//
//  ExtensionTexts.swift
//  AppTests
//
//  Created by Lucas Paim on 23/05/21.
//  Copyright © 2021 com.example.marvel. All rights reserved.
//

import XCTest
@testable import Network

class AppCoreExtensionTests: XCTestCase {

    func test_CheckIf_md5_returns_correct_hash() {
        // Given
        let value = "teste"
        
        //When
        let md5 = value.md5
        
        //Then
        XCTAssertEqual(md5, "698dc19d489c4e4db73e28a713eab07b")
    }

}
