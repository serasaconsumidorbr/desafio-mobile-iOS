//
//  CharacterRequest.swift
//  MarvelCharacters
//
//  Created by iris on 21/05/23.
//

import Foundation

struct CharacterRequest: Request {
    
    // MARK: - CASES
    
    enum Req {
        case characters(model: CharactersRequestModel)
    }
    
    let cases: Req
    
    // MARK: - REQUEST PROTOCOL
    
    var scheme: String {
        switch cases {
        default:
            return "https"
        }
    }
    
    var method: HTTPMethod {
        switch cases {
        default:
            return .get
        }
    }
    
    var baseURL: String {
        switch cases {
        default:
            return "gateway.marvel.com"
        }
    }
    
    var path: String {
        switch cases {
        case .characters:
            return "/v1/public/characters"
        }
    }
    
    var parameters: [URLQueryItem] {
        let timestamp = "\(Date().timeIntervalSince1970)"
        let privateKey = "2f1e888aa7ef830570c1b2f088ef5499281b8c12"
        let apiKey = "93359d297fb9e465aea24e94a3669e1e"
        let hash = "\(timestamp)\(privateKey)\(apiKey)".md5
        var queryItems = [URLQueryItem(name: "ts", value: timestamp),
                         URLQueryItem(name: "hash", value: hash),
                         URLQueryItem(name: "apikey", value: apiKey)]
        
        switch cases {
        case .characters(let request):
            queryItems.append(contentsOf: request.asQueryItens())
            return queryItems
        }
    }
}
