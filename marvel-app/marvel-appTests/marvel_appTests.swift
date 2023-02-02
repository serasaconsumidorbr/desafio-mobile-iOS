//
//  HomeViewModelTests.swift
//  marvel-appTests
//
//  Created by Leonardo Bandeira on 01/02/23.
//

@testable import Alamofire
import SDWebImage
import XCTest

@testable import marvel_app

private class HomeServiceMock: HomeServicing {
    var getCharactersResult: Result<[Character]?, AFError> = .failure(AFError.explicitlyCancelled)
    func getCharacters(limit: Int, offset: Int, completion: @escaping (Result<[Character]?, AFError>) -> Void) {
        completion(getCharactersResult)
    }
}

private class HomeDisplayingSpy: HomeDisplaying {
    enum Message: AutoEquatable {
        case displayCharacters([SectionModel])
        case displayLoading(Bool)
        case displayFailure
    }
    
    private(set) var messages = [Message]()
    
    func displayCharacters(with model: [marvel_app.SectionModel]) {
        messages.append(.displayCharacters(model))
    }
    
    func displayLoading(_ bool: Bool) {
        messages.append(.displayLoading(bool))
    }
    
    func displayFailure() {
        messages.append(.displayFailure)
    }
}

// MARK: - Setup SUT.
private extension HomeViewModelTests {
    typealias DependencySUT = (
        sut: HomeViewModel,
        serviceMock: HomeServiceMock,
        displaySpy: HomeDisplayingSpy
    )
    
    func makeSUT() -> DependencySUT {
        let displaySpy = HomeDisplayingSpy()
        let serviceMock = HomeServiceMock()
        let sut = HomeViewModel(service: serviceMock)
        
        sut.viewController = displaySpy
        
        return (sut, serviceMock, displaySpy)
    }
}

// MARK: - Test(s).
final class HomeViewModelTests: XCTestCase {
    func testperformLoading_ShouldCallDisplayLoading() {
        let args = makeSUT()
        
        args.sut.performLoading(true)
        
        XCTAssertEqual(args.displaySpy.messages, [.displayLoading(true)])
    }
}
