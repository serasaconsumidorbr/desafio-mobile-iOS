//
//  Infos+Dummy.swift
//  marvel-charactersTests
//
//  Created by Paulo Atavila on 07/06/21.
//

@testable import marvel_characters

extension ComicList {
    static func dummy() -> ComicList {
        return ComicList(
            available: 1,
            collectionURI: nil,
            items: [ComicSummary.dummy()],
            returned: 1
        )
    }
}

extension ComicSummary {
    static func dummy() -> ComicSummary {
        return ComicSummary(resourceURI: nil, name: "Comic Summary")
    }
}

extension SeriesList {
    static func dummy() -> SeriesList {
        return SeriesList(
            available: 1,
            collectionURI: nil,
            items: [SeriesSummary.dummy()],
            returned: 1
        )
    }
}

extension SeriesSummary {
    static func dummy() -> SeriesSummary {
        return SeriesSummary(resourceURI: nil, name: "Series Summary")
    }
}

extension StoryList {
    static func dummy() -> StoryList {
        return StoryList(
            available: 1,
            collectionURI: nil,
            items: [StorySummary.dummy()],
            returned: 1
        )
    }
}

extension StorySummary {
    static func dummy() -> StorySummary {
        return StorySummary(resourceURI: nil, name: "Story Summary")
    }
}

extension EventList {
    static func dummy() -> EventList {
        return EventList(
            available: 1,
            collectionURI: nil,
            items: [EventSummary.dummy()],
            returned: 1
        )
    }
}

extension EventSummary {
    static func dummy() -> EventSummary {
        return EventSummary(resourceURI: nil, name: "Event Summary")
    }
}

extension URLElement {
    static func dummy() -> URLElement {
        return URLElement(type: "type", url: nil)
    }
}

extension Thumbnail {
    static func dummy() -> Thumbnail {
        return Thumbnail(path: "path", thumbnailExtension: "extension")
    }
}
