//
//  MarvelKeys.swift
//  Marvel (iOS)
//
//  Created by Matheus Custódio on 26/07/22.
//

import Foundation

struct MarvelKeys {
    static let publicKey  = "d2977d8e69f8f68e0df761149c6ebc18"
    static let priveteKey = "5b8780c3f5ae35b8ca6059f7cf62d749a339eb43"
    static let mainURL = "https://gateway.marvel.com:443/v1/public"    
    static var hashParam: String {
        let ts = String(Date().timeIntervalSince1970)
        let hash =  "\(ts)\(priveteKey)\(publicKey)"
        return "&ts=\(ts)&apikey=\(publicKey)&hash=\(hash.MD5)"
    }
}
