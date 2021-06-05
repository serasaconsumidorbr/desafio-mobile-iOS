//
//  CharactersListViewModel.swift
//  marvel-characters
//
//  Created by Paulo Atavila on 05/06/21.
//

import Foundation

protocol CharactersListViewModelProtocol {
    func getCharactersList()
}

class CharactersListViewModel: CharactersListViewModelProtocol {
    let service: CharactersListServiceProtocol
    private (set) var charactersList: [Character]
    
    init(service: CharactersListServiceProtocol = CharactersListService()) {
        self.service = service
        charactersList = []
    }
    
    func getCharactersList() {
        
        service.fetchCharctersList { result in
            switch result {
            
            case .success(let data):
                self.charactersList = data.data?.results ?? []
            case .failure(_):
                self.charactersList = []
            }
        }
    }
    
}
