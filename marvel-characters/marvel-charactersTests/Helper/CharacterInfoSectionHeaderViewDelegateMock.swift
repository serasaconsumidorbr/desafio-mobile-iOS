//
//  CharacterInfoSectionHeaderViewDelegateMock.swift
//  marvel-charactersTests
//
//  Created by Paulo Atavila on 07/06/21.
//

@testable import marvel_characters

class CharacterInfoSectionHeaderViewDelegateMock: CharacterInfoSectionHeaderViewDelegateProtocol {
    private (set) var didPressSectionWasCalled: Bool = false
    
    func didPressSection(_ section: Int) {
        didPressSectionWasCalled = true
    }
}
