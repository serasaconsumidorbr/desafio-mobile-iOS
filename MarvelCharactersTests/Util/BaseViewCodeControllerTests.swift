//
//  BaseViewCodeControllerTests.swift
//  MarvelCharactersTests
//
//  Created by Gabriel Beltrame Silva on 05/04/23.
//

import Foundation
import Nimble
import XCTest
@testable import MarvelCharacters

final class BaseViewCodeControllerTests: XCTestCase {
    
    func testUnimplementedMethods() {
        let viewController = BaseViewCodeController()
        
        expect(viewController.addSubviews())
            .to(throwAssertion())
        
        expect(viewController.setupConstraints())
            .to(throwAssertion())
        
        expect(viewController.setupSubviews())
            .to(throwAssertion())
    }
}

