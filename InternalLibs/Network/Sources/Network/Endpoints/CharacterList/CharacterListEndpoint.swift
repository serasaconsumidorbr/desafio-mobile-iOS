//
//  File.swift
//  
//
//  Created by Lucas Paim on 23/05/21.
//

import Foundation
import PromiseKit
import Alamofire

public protocol CharacterService {
    func request(parameters: CharacterListParameters) -> Promise<CharacterListResponse>
}


final class CharacterServiceImpl: EndPoint, CharacterService {
    
    var uri: String { Network.ServerUri }
    var path: String { "/v1/public/characters" }
    
    var encoder: ParameterEncoding { URLEncoding.default }
    var method: HTTPMethod { .get }

    typealias ParameterType = CharacterListParameters
    typealias ResponseType = CharacterListResponse
    
}
