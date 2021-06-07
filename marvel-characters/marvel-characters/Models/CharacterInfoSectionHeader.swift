//
//  CharacterInfoSectionHeader.swift
//  marvel-characters
//
//  Created by Paulo Atavila on 07/06/21.
//

import UIKit

struct CharacterInfoSectionHeader {
    let type: CharacterInfoSectionHederType
    var isOpen: Bool
    var section: Int
    
    init(type: CharacterInfoSectionHederType, section: Int = 0) {
        self.type = type
        isOpen = false
        self.section = section
    }
}

enum CharacterInfoSectionHederType {
    case description, comics, series, stories, events, urls
    
    var title: String {
        switch self {
        case .description:
            return "Description"
        case .comics:
            return "Comics"
        case .series:
            return "Series"
        case .stories:
            return "Stories"
        case .events:
            return "Events"
        case .urls:
            return "Other infos"
        }
    }
    
    var image: UIImage {
        switch self {
        case .description:
            return Icons.info.image
        case .comics:
            return Icons.comic.image
        case .series:
            return Icons.series.image
        case .stories:
            return Icons.story.image
        case .events:
            return Icons.event.image
        case .urls:
            return Icons.url.image
        }
    }
}
