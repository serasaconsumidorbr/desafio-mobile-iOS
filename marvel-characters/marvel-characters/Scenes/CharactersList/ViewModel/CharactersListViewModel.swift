//
//  CharactersListViewModel.swift
//  marvel-characters
//
//  Created by Paulo Atavila on 05/06/21.
//

import Foundation

protocol CharactersListViewModelProtocol {
    func getCharactersList(comletion: @escaping () -> Void)
    func getNumberOfCharacters() -> Int
    func getCharacterAt(_ index: Int) -> Character?
    func getNumberOfFirstsCharacters() -> Int
    func getFirstsCharacterAt(_ index: Int) -> Character?
    var hasItemsToLoad: Bool { get }
    var isLoadingRequest: Bool { get }
    var lastRequestSuccess: Bool { get }
}

class CharactersListViewModel: CharactersListViewModelProtocol {
    let service: CharactersListServiceProtocol
    let maxNumberOfFirstItems: Int
    private var charactersList: [Character]
    private var firtsCharactersList: [Character]
    private var totalItemsToBeReceived: Int
    private var returnedAmount: Int
    var hasItemsToLoad: Bool {
        let totalReceived = charactersList.count + firtsCharactersList.count
        return totalReceived < totalItemsToBeReceived
    }
    var isLoadingRequest: Bool
    var lastRequestSuccess: Bool
    
    init(service: CharactersListServiceProtocol = CharactersListService()) {
        self.service = service
        lastRequestSuccess = true
        isLoadingRequest = false
        maxNumberOfFirstItems = 5
        totalItemsToBeReceived = 0
        returnedAmount = 0
        
        firtsCharactersList = []
        charactersList = []
    }
    
    func getCharactersList(comletion: @escaping () -> Void) {
        isLoadingRequest = true
        
        service.fetchCharctersList(offset: returnedAmount) { [weak self] result in
            self?.isLoadingRequest = false
            
            switch result {
            case .success(let data):
                self?.lastRequestSuccess = true
                self?.totalItemsToBeReceived = data.data?.total ?? 0
                self?.returnedAmount += data.data?.count ?? 0
                
                if var items = data.data?.results {
                    if self?.firtsCharactersList.count == 0 {
                        self?.firtsCharactersList = Array(items.prefix(5))
                        if items.count > 5 {
                            items.removeSubrange(0...4)
                        } else {
                            items.removeAll()
                        }
                    }
                    self?.charactersList.append(contentsOf: items)
                }
            case .failure(_):
                self?.lastRequestSuccess = false
                self?.charactersList = []
                self?.firtsCharactersList = []
            }
            comletion()
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
    
    func getNumberOfFirstsCharacters() -> Int {
        return firtsCharactersList.count
    }
    
    func getFirstsCharacterAt(_ index: Int) -> Character? {
        if index >= 0 && index < firtsCharactersList.count {
            return firtsCharactersList[index]
        }
        return nil
    }
    
    func defaultCharacter() -> Character {
        return Character(
            id: 1017100,
            name: "A-Bomb (HAS)",
            characterDescription: "Rick Jones has been Hulk's best bud since day one, but now he's more than a friend...he's a teammate! Transformed by a Gamma energy explosion, A-Bomb's thick, armored skin is just as strong and powerful as it is blue. And when he curls into action, he uses it like a giant bowling ball of destruction!",
            thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16", thumbnailExtension: "jpg"), resourceURI: "http://gateway.marvel.com/v1/public/characters/1017100",
            comics: ComicList(available: 10, collectionURI: "http://gateway.marvel.com/v1/public/characters/1017100/comics", items: [ComicSummary(resourceURI: "http://gateway.marvel.com/v1/public/comics/40632", name: "Hulk (2008) #53"), ComicSummary(resourceURI: "http://gateway.marvel.com/v1/public/comics/40630", name: "Hulk (2008) #54"), ComicSummary(resourceURI: "http://gateway.marvel.com/v1/public/comics/40628", name: "Hulk (2008) #55")], returned: 3),
            series: SeriesList(available: 2, collectionURI: "http://gateway.marvel.com/v1/public/characters/1017100/series", items: [SeriesSummary(resourceURI: "http://gateway.marvel.com/v1/public/series/17765", name: "FREE COMIC BOOK DAY 2013 1 (2013)"), SeriesSummary(resourceURI: "http://gateway.marvel.com/v1/public/series/3374", name: "Hulk (2008 - 2012)")], returned: 2),
            stories: StoryList(available: 2, collectionURI: "http://gateway.marvel.com/v1/public/characters/1017100/stories", items: [StorySummary(resourceURI: "http://gateway.marvel.com/v1/public/stories/92078", name: "Hulk (2008) #55"), StorySummary(resourceURI: "http://gateway.marvel.com/v1/public/stories/92079", name: "Interior #92079")], returned: 2),
            events: EventList(available: nil, collectionURI: nil, items: nil, returned: 0),
            urls: [URLElement(type: "detail", url: "http://marvel.com/characters/76/a-bomb?utm_campaign=apiRef&utm_source=007adb4eff0030e2e522cbc7f3c3e4d7"), URLElement(type: "comiclink", url: "http://marvel.com/comics/characters/1017100/a-bomb_has?utm_campaign=apiRef&utm_source=007adb4eff0030e2e522cbc7f3c3e4d7")])
    }
}
