//
//  FetchComicsParameters.swift
//  Marvel
//
//  Created by João Pedro on 22/04/21.
//

import Foundation

public struct FetchComicsParameters: RequestParameters {
    public let characterId: Int
    public let offset: Int
    public let limit: Int

    public init(characterId: Int, offset: Int, limit: Int = 20) {
      self.characterId = characterId
      self.offset = offset
      self.limit = limit
    }

    enum CodingKeys: String, CodingKey {
        case offset, limit
    }
}
