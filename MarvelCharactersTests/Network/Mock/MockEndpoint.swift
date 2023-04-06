//
//  MockEndpoint.swift
//  MarvelCharactersTests
//
//  Created by Gabriel Beltrame Silva on 03/04/23.
//

import Alamofire
import Foundation
import MarvelCharacters

enum MockEndpoint: EndpointConvertible, Equatable {
    case test
    
    var endpoint: String {
        return "/test/endpoint"
    }
    
    var method: Alamofire.HTTPMethod {
        return .get
    }
    
    var additionalParameters: Alamofire.Parameters? {
        return nil
    }
    
    var encoding: Alamofire.ParameterEncoding {
        return URLEncoding.default
    }
    
    var headers: [HTTPHeader]? {
        return nil
    }
}
