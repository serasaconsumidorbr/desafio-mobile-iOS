//
//  HomeViewModelTests.swift
//  marvel-appTests
//
//  Created by Leonardo Bandeira on 01/02/23.
//

import Alamofire
import SDWebImage
import XCTest

@testable import marvel_app

private class HomeServiceMock: HomeServicing {
    var getCharactersResult: Result<[Character]?, AFError> = .failure(Failure())
    func getCharacters(limit: Int, offset: Int, completion: @escaping (Result<[Character]?, AFError>) -> Void) {
        completion(getCharactersResult)
    }
}

// MARK: - Setup SUT.
private extension HomeViewModelTests {
    func makeSUT() {
        let serviceMock = HomeServiceMock()
        var sut = HomeViewModel(service: serviceMock)
    }
}

final class HomeViewModelTests: XCTestCase {}
