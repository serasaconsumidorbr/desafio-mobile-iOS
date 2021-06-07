//
//  Icons.swift
//  marvel-characters
//
//  Created by Paulo Atavila on 07/06/21.
//

import UIKit

enum Icons {
    case comic, series, story, event, url, info, arrow, defaultCharacter
    
    var image: UIImage {
        switch self {
        case .comic:
            return UIImage(imageLiteralResourceName: "icon_comic_book")
        case .series:
            return UIImage(imageLiteralResourceName: "icon_series")
        case .story:
            return UIImage(imageLiteralResourceName: "icon_story")
        case .event:
            return UIImage(imageLiteralResourceName: "icon_event")
        case .url:
            return UIImage(imageLiteralResourceName: "icon_url")
        case .info:
            return UIImage(imageLiteralResourceName: "icon_info")
        case .arrow:
            return UIImage(imageLiteralResourceName: "icon_arrow")
        case .defaultCharacter:
            return UIImage(imageLiteralResourceName: "character_default")
        }
    }
}
