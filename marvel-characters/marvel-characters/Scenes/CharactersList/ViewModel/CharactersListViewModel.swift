//
//  CharactersListViewModel.swift
//  marvel-characters
//
//  Created by Paulo Atavila on 05/06/21.
//

import Foundation

protocol CharactersListViewModelProtocol {
    func getCharactersList()
    func getNumberOfCharacters() -> Int
    func getCharacterAt(_ index: Int) -> Character?
}

class CharactersListViewModel: CharactersListViewModelProtocol {
    let service: CharactersListServiceProtocol
    private (set) var charactersList: [Character]
    
    init(service: CharactersListServiceProtocol = CharactersListService()) {
        self.service = service
        charactersList = [
            Character(
                id: nil,
                name: "Mad Max - C St U",
                characterDescription: nil, thumbnail: nil, resourceURI: nil,
                comics: ComicList(available: nil, collectionURI: nil, items: nil, returned: 2),
                series: SeriesList(available: nil, collectionURI: nil, items: nil, returned: 0),
                stories: StoryList(available: nil, collectionURI: nil, items: nil, returned: 1),
                events: EventList(available: nil, collectionURI: nil, items: nil, returned: 0),
                urls: [URLElement(type: nil, url: nil), URLElement(type: nil, url: nil)])
            
        ]
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
    
    func getNumberOfCharacters() -> Int {
        return charactersList.count
    }
    
    func getCharacterAt(_ index: Int) -> Character? {
        if index >= 0 && index < charactersList.count {
            return charactersList[index]
        }
        return nil
    }
    
}
