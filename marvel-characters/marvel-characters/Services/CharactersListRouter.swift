//
//  CharactersListRouter.swift
//  marvel-characters
//
//  Created by Paulo Atavila on 05/06/21.
//

import Alamofire
import Foundation

enum CharactersListRouter: Router {

    case charactersList(Int)
    
    var path: String {
        switch self {
        case .charactersList:
            return "/v1/public/characters"
        }
    }
    
    var parameters: [String : String]? {
        switch self {
        case .charactersList(let offset):
            return ["offset" : String(offset)]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .charactersList:
            return .get
        }
    }
}
