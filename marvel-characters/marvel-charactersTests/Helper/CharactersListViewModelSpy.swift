//
//  CharactersListViewModelSpy.swift
//  marvel-charactersTests
//
//  Created by Paulo Atavila on 07/06/21.
//

@testable import marvel_characters

class CharactersListViewModelSpy: CharactersListViewModel {
    private (set) var requestCalledCount: Int = 0
    
    override func getCharactersList(comletion: @escaping () -> Void) {
        requestCalledCount += 1
        super.getCharactersList(comletion: comletion)
    }
    
    func resetRequestCalledCount() {
        requestCalledCount = 0
    }
}
