//
//  CharacterInfoViewModelSpy.swift
//  marvel-charactersTests
//
//  Created by Paulo Atavila on 07/06/21.
//

@testable import marvel_characters

class CharacterInfoViewModelSpy: CharacterInfoViewModel {
    private (set) var toggleSectionWasCalled: Bool = false
    
    override func toggleSectionAt(_ index: Int) {
        toggleSectionWasCalled = true
        super.toggleSectionAt(index)
    }
}
