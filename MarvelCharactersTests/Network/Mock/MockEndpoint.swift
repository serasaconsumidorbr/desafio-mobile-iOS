//
//  MockEndpoint.swift
//  MarvelCharactersTests
//
//  Created by Gabriel Beltrame Silva on 03/04/23.
//

import Alamofire
import Foundation
import MarvelCharacters

struct MockEndpoint: EndpointConvertible {
    var endpoint: String = "/test/endpoint"
    
    var method: Alamofire.HTTPMethod = .get
    
    var additionalParameters: Alamofire.Parameters? = nil
    
    var encoding: Alamofire.ParameterEncoding = URLEncoding.default
    
    var headers: Alamofire.HTTPHeaders? = nil
}
