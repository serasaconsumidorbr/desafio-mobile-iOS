//
//  FavoriteCharacter.swift
//  marvel-characters
//
//  Created by Paulo Atavila on 06/06/21.
//

// MARK: - Favorite Character
struct FavoriteCharacter: Decodable {
    let id: Int?
    let name: String?
    let thumbnail: Thumbnail?
    let resourceURI: String?
}
