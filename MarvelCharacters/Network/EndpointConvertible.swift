//
//  EndpointConvertible.swift
//  MarvelCharacters
//
//  Created by Gabriel Beltrame Silva on 03/04/23.
//

import Alamofire

public protocol EndpointConvertible {
    var baseURL: String { get }
    var endpoint: String { get }
    var method: HTTPMethod { get }
    var authenticationParameters: Parameters? { get }
    var additionalParameters: Parameters? { get }
    var encoding: ParameterEncoding { get }
    var headers: HTTPHeaders? { get }
    var convertible: URLConvertible { get }
}

public extension EndpointConvertible {
    var baseURL: String {
        return "https://developer.marvel.com"
    }
    
    var authenticationParameters: Parameters? {
        return [
            "ts": Date().ISO8601Format(),
            "apiKey": "",
            "hash": ""
        ]
    }
    
    var convertible: URLConvertible {
        return baseURL + endpoint
    }
}
