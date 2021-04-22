//
//  FetchCharactersParameters.swift
//  Marvel
//
//  Created by João Pedro on 21/04/21.
//

import Foundation

public struct FetchCharactersParameters: RequestParameters {
    public let offset: Int
    public let limit: Int

    public init(offset: Int, limit: Int = 20) {
      self.offset = offset
      self.limit = limit
    }
}
