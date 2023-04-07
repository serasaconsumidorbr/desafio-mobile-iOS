//
//  APIKeys.swift
//  MarvelCharacters
//
//  Created by Gabriel Beltrame Silva on 03/04/23.
//

import Foundation

class APIKeys {
    static var apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String
    static var apiSecret = Bundle.main.object(forInfoDictionaryKey: "API_SECRET") as? String
}
