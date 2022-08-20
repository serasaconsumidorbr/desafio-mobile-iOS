//
//  MarvelCharactersShowcaseTests.swift
//  MarvelCharactersShowcaseTests
//
//  Created by Henrique Legnaro on 18/08/22.
//

import XCTest
@testable import MarvelCharactersShowcase

class CharactersRepositoryTests: XCTestCase {

    var sut: CharactersRepository!
    
    override func setUpWithError() throws {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        sut = CharactersRepository(urlSession: urlSession)
    }

    override func tearDownWithError() throws {
        sut = nil
        MockURLProtocol.stubResponseData = nil
        MockURLProtocol.error = nil
    }

    func testCharactersRequest_WhenGivenInvalidURL_ShouldReturnInvalidURLError() throws {
        let expectation = self.expectation(description: "A failed Request expectation")
        
        let jsonString = "{\"status\":}"
        MockURLProtocol.stubResponseData = jsonString.data(using: .utf8)
        
        sut.fetchCharacters(urlString: K.charactersUrl) { response, error in
            
            XCTAssertEqual(error, .invalidResponseModel)
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 2)
    }
    
    func testCharactersRequest_WhenFailedParsingResponse_ShouldReturnParsingError() throws {
        let expectation = self.expectation(description: "A failed Request expectation")
        
        sut.fetchCharacters(urlString: "spodermein@teia") { response, error in
            
            XCTAssertEqual(error, .invalidURL)
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 2)
    }
    
    func testCharactersRequest_WhenURLRequestFails_ShouldReturnErrorDescription() throws {
        let expectation = self.expectation(description: "A failed Request expectation")
        
        let jsonString = "{\"status\":\"ok\"}"
        MockURLProtocol.stubResponseData = jsonString.data(using: .utf8)
        
        MockURLProtocol.error = ApiErrors.failedRequest(description: "Error")
        
        sut.fetchCharacters(urlString: K.charactersUrl) { response, error in
            
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 2)
    }

    func testCharactersRequest_WhenRequestSucceded_ShouldReturnSucess() throws {
        let expectation = self.expectation(description: "A success Request expactation")
        
        let jsonString = "{\"status\":\"ok\"}"
        MockURLProtocol.stubResponseData = jsonString.data(using: .utf8)
        
        sut.fetchCharacters(urlString: K.charactersUrl) { response, error in
            
            XCTAssertEqual(response?.status, "ok")
            XCTAssertNil(error)
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 2)
    }
    

}
