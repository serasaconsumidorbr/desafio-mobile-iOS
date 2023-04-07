//
//  CharacterListRouterTests.swift
//  MarvelCharactersTests
//
//  Created by Gabriel Beltrame Silva on 07/04/23.
//

import Foundation
import Nimble
import XCTest
@testable import MarvelCharacters

final class CharacterListRouterTests: XCTestCase {
    
    func testShowOptions() {
        let sut = makeSut()
        
        sut.router.showOptions(reloadDelegate: nil)
        
        guard sut.viewController.calledMethods.count == 1, case let .present(viewController, animated) = sut.viewController.calledMethods[0] else {
            XCTFail("Wrong View Controller Type")
            return
        }
        
        expect(viewController)
            .to(beAnInstanceOf(ListOptionsViewController.self))
        
        expect(animated)
            .to(beTrue())
    }
    
    fileprivate func makeSut() -> SUT {
        let router = CharacterListRouter()
        let viewController = ViewControllerMock()
        
        router.viewController = viewController
        
        return SUT(
            router: router,
            viewController: viewController
        )
    }
    
    fileprivate struct SUT {
        let router: CharacterListRouter
        let viewController: ViewControllerMock
    }
}
