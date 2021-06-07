//
//  ServiceTestCase.swift
//  marvel-charactersTests
//
//  Created by Paulo Atavila on 07/06/21.
//

import Alamofire
import XCTest

@testable import marvel_characters

class ServiceTestCase: XCTestCase {

    var sut: Service!
    
    override func setUp() {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let manager = Session(configuration: configuration)
        sut = Service(manager: manager)
    }

    override func tearDown() {
        sut = nil
    }
    
    func testSuccessRequest() {
        MockURLProtocol.responseWithStatusCode(code: 200)
        
        let expectation = XCTestExpectation(description: "Performs a success request")
        let router = CharactersListRouter.charactersList(0)
        sut.fetch(router: router, of: CharacterDataWrapper.self) { result in
            switch result {
            case .success(_):
                expectation.fulfill()
            case .failure(_): break
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3)
    }
    
    func testFailureRequest() {
        MockURLProtocol.responseWithFailure()
        
        let expectation = XCTestExpectation(description: "Performs a failure request")
        let router = CharactersListRouter.charactersList(0)
        sut.fetch(router: router, of: CharacterDataWrapper.self) { result in
            switch result {
            case .success(_): break
            case .failure(_):
                expectation.fulfill()
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3)
    }
}
