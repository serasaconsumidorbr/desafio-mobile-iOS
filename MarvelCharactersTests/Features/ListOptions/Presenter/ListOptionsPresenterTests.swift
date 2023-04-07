//
//  ListOptionsPresenterTests.swift
//  MarvelCharactersTests
//
//  Created by Gabriel Beltrame Silva on 06/04/23.
//

import Foundation
import Nimble
import XCTest
@testable import MarvelCharacters

final class ListOptionsPresenterTests: XCTestCase {
    
    func testDidLoadOptions() {
        let sut = makeSut()
        
        sut.presenter.didLoadOptions(ListOptions.defaultValue)
        
        expect(sut.viewController.calledMethods)
            .toEventually(
                equal([
                    .updateOptions(listOptions: ListOptions.defaultValue)
                ])
            )
    }
    
    fileprivate func makeSut() -> SUT {
        let presenter = ListOptionsPresenter()
        let viewController = ListOptionsViewControllerProtocolMock()
        
        presenter.viewController = viewController
        
        return SUT(
            presenter: presenter,
            viewController: viewController
        )
    }
    
    fileprivate struct SUT {
        let presenter: ListOptionsPresenterProtocol
        let viewController: ListOptionsViewControllerProtocolMock
    }
}
