//
//  MockEndpoint.swift
//  MarvelCharactersTests
//
//  Created by Gabriel Beltrame Silva on 03/04/23.
//

import Alamofire
import Foundation
import MarvelCharacters

struct MockEndpoint: EndpointConvertible, Equatable {
    var endpoint: String = "/test/endpoint"
    
    var method: Alamofire.HTTPMethod = .get
    
    var additionalParameters: Alamofire.Parameters? = nil
    
    var encoding: Alamofire.ParameterEncoding = URLEncoding.default
    
    var headers: [HTTPHeader]? = nil
    
    static func == (lhs: MockEndpoint, rhs: MockEndpoint) -> Bool {
        return (lhs.baseURL == rhs.baseURL) &&
        (lhs.endpoint == rhs.endpoint) &&
        (lhs.method == rhs.method) &&
        (lhs.additionalParameters == rhs.additionalParameters) &&
        (lhs.headers == rhs.headers)
    }
}
