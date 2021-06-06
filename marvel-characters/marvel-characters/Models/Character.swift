//
//  Character.swift
//  marvel-characters
//
//  Created by Paulo Atavila on 04/06/21.
//

import Foundation

// MARK: - Character
struct Character: Decodable {
    let id: Int?
    let name: String?
    let characterDescription: String?
    let thumbnail: Thumbnail?
    let resourceURI: String?
    let comics: ComicList?
    let series: SeriesList?
    let stories: StoryList?
    let events: EventList?
    let urls: [URLElement]?

    enum CodingKeys: String, CodingKey {
        case id, name, thumbnail, resourceURI, comics, series, stories, events, urls
        case characterDescription = "description"
    }
}

// MARK: - ComicList
struct ComicList: Decodable {
    let available: Int?
    let collectionURI: String?
    let items: [ComicSummary]?
    let returned: Int?
}

// MARK: - ComicItem
struct ComicSummary: Decodable {
    let resourceURI: String?
    let name: String?
}

// MARK: - StoryList
struct StoryList: Decodable {
    let available: Int?
    let collectionURI: String?
    let items: [StorySummary]?
    let returned: Int?
}

// MARK: - StoryItem
struct StorySummary: Decodable {
    let resourceURI: String?
    let name: String?
}

enum StoryType: String, Codable {
    case cover = "cover"
    case interiorStory = "interiorStory"
}

// MARK: - EventList
struct EventList: Decodable {
    let available: Int?
    let collectionURI: String?
    let items: [EventSummary]?
    let returned: Int?
}

// MARK: - EventItem
struct EventSummary: Decodable {
    let resourceURI: String?
    let name: String?
}

// MARK: - SeriesList
struct SeriesList: Decodable {
    let available: Int?
    let collectionURI: String?
    let items: [SeriesSummary]?
    let returned: Int?
}

// MARK: - SeriesSummary
struct SeriesSummary: Decodable {
    let resourceURI: String?
    let name: String?
}

// MARK: - Thumbnail
struct Thumbnail: Decodable {
    let path: String?
    let thumbnailExtension: String?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// MARK: - URLElement
struct URLElement: Decodable {
    let type: String?
    let url: String?
}
