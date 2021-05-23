//
//  NetworkConstantsTests.swift
//  AppTests
//
//  Created by Lucas Paim on 23/05/21.
//  Copyright © 2021 com.example.marvel. All rights reserved.
//

import XCTest
@testable import Network

class NetworkConstantsTests: XCTestCase {

    func test_CheckIf_PublicKey_Are_Not_Nil() {
        // Given
        let key = NetworkConstants.publicKey
        
        //When
        // ...
        
        //Then
        XCTAssertNotNil(key)
    }
    
    func test_CheckIf_PrivateKey_Are_Not_Nil() {
        // Given
        let key = NetworkConstants.privateKey
        
        //When
        // ...
        
        //Then
        XCTAssertNotNil(key)
    }

}
