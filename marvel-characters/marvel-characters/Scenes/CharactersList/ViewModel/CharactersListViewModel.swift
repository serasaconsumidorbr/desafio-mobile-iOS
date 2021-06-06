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
    func getNumberOfFavoriteCharacters() -> Int
    func getFavoriteCharacterAt(_ index: Int) -> FavoriteCharacter?
}

class CharactersListViewModel: CharactersListViewModelProtocol {
    let service: CharactersListServiceProtocol
    private (set) var charactersList: [Character]
    private (set) var favoriteCharactersList: [FavoriteCharacter]
    
    init(service: CharactersListServiceProtocol = CharactersListService()) {
        self.service = service
        favoriteCharactersList = []
        charactersList = [
            Character(
                id: 1017100,
                name: "A-Bomb (HAS)",
                characterDescription: "Rick Jones has been Hulk's best bud since day one, but now he's more than a friend...he's a teammate! Transformed by a Gamma energy explosion, A-Bomb's thick, armored skin is just as strong and powerful as it is blue. And when he curls into action, he uses it like a giant bowling ball of destruction!",
                thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16", thumbnailExtension: "jpg"), resourceURI: "http://gateway.marvel.com/v1/public/characters/1017100",
                comics: ComicList(available: 10, collectionURI: "http://gateway.marvel.com/v1/public/characters/1017100/comics", items: [ComicSummary(resourceURI: "http://gateway.marvel.com/v1/public/comics/40632", name: "Hulk (2008) #53"), ComicSummary(resourceURI: "http://gateway.marvel.com/v1/public/comics/40630", name: "Hulk (2008) #54"), ComicSummary(resourceURI: "http://gateway.marvel.com/v1/public/comics/40628", name: "Hulk (2008) #55")], returned: 3),
                series: SeriesList(available: 2, collectionURI: "http://gateway.marvel.com/v1/public/characters/1017100/series", items: [SeriesSummary(resourceURI: "http://gateway.marvel.com/v1/public/series/17765", name: "FREE COMIC BOOK DAY 2013 1 (2013)"), SeriesSummary(resourceURI: "http://gateway.marvel.com/v1/public/series/3374", name: "Hulk (2008 - 2012)")], returned: 2),
                stories: StoryList(available: 2, collectionURI: "http://gateway.marvel.com/v1/public/characters/1017100/stories", items: [StorySummary(resourceURI: "http://gateway.marvel.com/v1/public/stories/92078", name: "Hulk (2008) #55"), StorySummary(resourceURI: "http://gateway.marvel.com/v1/public/stories/92079", name: "Interior #92079")], returned: 2),
                events: EventList(available: nil, collectionURI: nil, items: nil, returned: 0),
                urls: [URLElement(type: "detail", url: "http://marvel.com/characters/76/a-bomb?utm_campaign=apiRef&utm_source=007adb4eff0030e2e522cbc7f3c3e4d7"), URLElement(type: "comiclink", url: "http://marvel.com/comics/characters/1017100/a-bomb_has?utm_campaign=apiRef&utm_source=007adb4eff0030e2e522cbc7f3c3e4d7")])
        ]
        favoriteCharactersList.append(FavoriteCharacter(id: nil, name: "Homem de Ferro", thumbnail: nil, resourceURI: nil))
        favoriteCharactersList.append(FavoriteCharacter(id: nil, name: "Capitão América", thumbnail: nil, resourceURI: nil))
        favoriteCharactersList.append(FavoriteCharacter(id: nil, name: "Capitão América com o nome gigante", thumbnail: nil, resourceURI: nil))
        favoriteCharactersList.append(FavoriteCharacter(id: nil, name: "Spider Man", thumbnail: nil, resourceURI: nil))
    }
    
    func getCharactersList(comletion: @escaping () -> Void) {
        service.fetchCharctersList { result in
            switch result {
            case .success(let data):
                self.charactersList = data.data?.results ?? []
            case .failure(_):
                self.charactersList = []
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
    
    func getNumberOfFavoriteCharacters() -> Int {
        return favoriteCharactersList.count
    }
    
    func getFavoriteCharacterAt(_ index: Int) -> FavoriteCharacter? {
        if index >= 0 && index < favoriteCharactersList.count {
            return favoriteCharactersList[index]
        }
        return nil
    }
    
}
