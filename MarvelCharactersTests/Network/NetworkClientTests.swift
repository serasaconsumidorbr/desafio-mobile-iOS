//
//  NetworkClientTests.swift
//  MarvelCharactersTests
//
//  Created by Gabriel Beltrame Silva on 03/04/23.
//

import Alamofire
import OHHTTPStubs
import XCTest
@testable import MarvelCharacters

final class NetworkClientTests: XCTestCase {

    override func tearDownWithError() throws {
        HTTPStubs.removeAllStubs()
    }

    func testNetworkRequestSuccess() {
        let networkClient = NetworkClient()
        
        stub(condition: isMethodGET()) { _ in
          return HTTPStubsResponse(
            jsonObject: ["key": "value", "number": 12],
            statusCode: 200,
            headers: [ "Content-Type": "application/json" ]
          )
        }
        
        let expectation = expectation(description: "Wait for async completion")
        
        networkClient.makeRequest(to: MockEndpoint.test, of: MockObject.self) { result in
            switch result {
            case .success:
                break
            case let .failure(error):
                XCTFail("Failed request with error \(error)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testNetworkRequestError() {
        let networkClient = NetworkClient()
        
        stub(condition: isMethodGET()) { _ in
            return HTTPStubsResponse(error: AFError.invalidURL(url: MockEndpoint.test.convertible))
        }
        
        let expectation = expectation(description: "Wait for async completion")
        
        networkClient.makeRequest(to: MockEndpoint.test, of: MockObject.self) { result in
            switch result {
            case .success:
                XCTFail("Request should not be successful")
            case .failure:
                break
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
    }
}
