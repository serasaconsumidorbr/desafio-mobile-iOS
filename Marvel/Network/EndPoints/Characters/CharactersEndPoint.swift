//
//  CharactersEndPoint.swift
//  Marvel
//
//  Created by João Pedro on 21/04/21.
//
 
import Alamofire
import Foundation

public enum CharactersEndPoint {
    case fetchCharacters(parameters: FetchCharactersParameters)
    case fetchComics(parameters: FetchComicsParameters)
}

extension CharactersEndPoint: EndPointType {

    public var service: NetworkService {
        return .characters
    }

    public var path: String {
        switch self {
        case .fetchCharacters:
            return ""
        case .fetchComics(let parameters):
            return "\(parameters.characterId)/comics"
        }
    }

    public var httpMethod: HTTPMethod {
        switch self {
        case .fetchCharacters:
            return .get
        case .fetchComics:
            return .get
        }
    }

    public var headers: HTTPHeaders? {
        return nil
    }

    public var parameters: Parameters? {
        switch self {
        case .fetchCharacters(let parameters):
            return parameters.dictionary
        case .fetchComics(let parameters):
            return parameters.dictionary
        }
    }

    public var encoding: ParameterEncoding {
        URLEncoding.default
    }

    public var name: String {
        return String(describing: self)
    }
}
