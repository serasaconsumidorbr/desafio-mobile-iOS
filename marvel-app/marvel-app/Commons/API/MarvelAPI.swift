//
//  MarvelAPI.swift
//  Marvel Characters
//
//  Created by Leonardo Bandeira on 30/01/23.
//

import Foundation

final class MarvelAPI {
    static let publicKey = "4858d2a01439c45e4211663847b8342b"
    static let privateKey = "90bfefb7f2b7bd6902126ff48e9ae120b99b1a9d"
    
    enum Endpoint{
        case characters(Int, Int)
        
        static let baseURL = "https://gateway.marvel.com:443/v1/public/characters"
        static let apiKeyParam = "?apikey=\(publicKey)"
        
        var hashParam: String {
            let timestamp = Date().currentTimeInMillis()
            return "&ts=\(timestamp)&hash=" + ("\(timestamp)\(privateKey)\(publicKey)".md5Value)
        }
        
        var path: String {
            switch self {
            case let .characters(limit, offset):
                return Endpoint.baseURL + Endpoint.apiKeyParam + hashParam + "&limit=\(limit)&offset=\(offset)"
            }
        }
    }
}




