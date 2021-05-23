//
//  File.swift
//  
//
//  Created by Lucas Paim on 23/05/21.
//

import Foundation

public typealias CharacterListResponse = ResponseWrapper<PaginationWrapper<CharacterResponse>>

public struct CharacterResponse: Decodable {
    public let id: Int
    public let name: String
    public let description: String
    public let thumbnail: [Image]
}
