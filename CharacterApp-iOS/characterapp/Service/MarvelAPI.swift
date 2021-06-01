//
//  MarvelAPI.swift
//  characterapp
//
//  Created by Denys Galante on 01/06/2021.
//  Copyright © 2021 Denys Galante. All rights reserved.
//

import Foundation

class MarvelAPI {
    
    static let shared = MarvelAPI(
        baseURL: URL(string: "https://gateway.marvel.com:443")!,
        privateKey: "76cb8d0bd88b49abe3e4d049e6064518062f998c",
        apiKey: "1951bc8fc24c16592930f688c6df1581"
        
    )

    lazy var characterService: MVLCharacterService = {
        return MVLCharacterService(baseURL: baseURL, privateKey: privateKey, apiKey: apiKey)
    }()
    
    private let baseURL: URL
    private let privateKey: String
    private let apiKey: String
    
    init(baseURL: URL, privateKey: String, apiKey: String) {
        self.baseURL = baseURL
        self.privateKey = privateKey
        self.apiKey = apiKey
    }
    
}
