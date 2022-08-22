//
//  Constants.swift
//  MarvelCharactersShowcase
//
//  Created by Henrique Legnaro on 18/08/22.
//

import Foundation
import Hash

struct K {
    static let charactersUrl = "https://gateway.marvel.com:443/v1/public/characters"
    static let publicApi = Bundle.main.object(forInfoDictionaryKey: "publicAPIKey") as? String ?? ""
    static let privateApi = Bundle.main.object(forInfoDictionaryKey: "privateAPIKey") as? String ?? ""
    static let ts = String(NSDate().timeIntervalSince1970)
    static let hash = Hash(message: K.ts + K.privateApi + K.publicApi, algorithm: .md5)?.description
}
