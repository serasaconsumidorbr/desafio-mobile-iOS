//
//  CharacterEndpoint.swift
//  MarvelCharacters
//
//  Created by Gabriel Beltrame Silva on 03/04/23.
//

import Alamofire
import Foundation

enum CharacterEndpoint: EndpointConvertible, Equatable {
    case list(offset: Int, limit: Int, order: String)
    
    var endpoint: String {
        switch self {
        case .list:
            return "/v1/public/characters"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .list:
            return .get
        }
    }
    
    var additionalParameters: Parameters? {
        switch self {
        case let .list(offset, limit, order):
            return ["offset": offset, "limit": limit, "orderBy": order]
        }
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var headers: [HTTPHeader]? {
        return nil
    }
}
