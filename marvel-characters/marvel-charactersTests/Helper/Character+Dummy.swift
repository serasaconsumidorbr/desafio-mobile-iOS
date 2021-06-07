//
//  Character+Dummy.swift
//  marvel-charactersTests
//
//  Created by Paulo Atavila on 06/06/21.
//

@testable import marvel_characters

extension Character {
    enum CharacterType: String {
        case collection, regular
    }
    
    static func dummy(type: CharacterType = .regular) -> Character {
        return Character(
            id: 12345,
            name: "Test Character \(type.rawValue)",
            characterDescription: "Test Character Description \(type.rawValue)",
            thumbnail: Thumbnail.dummy(),
            resourceURI: nil,
            comics: ComicList.dummy(),
            series: SeriesList.dummy(),
            stories: StoryList.dummy(),
            events: EventList.dummy(),
            urls: [URLElement.dummy()]
        )
    }
}
