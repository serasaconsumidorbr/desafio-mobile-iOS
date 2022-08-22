//
//  Formatter.swift
//  MarvelCharactersShowcase
//
//  Created by Henrique Legnaro on 18/08/22.
//

import Foundation
import UIKit

class Formatter {
    
    static func FormatURL(url: String, offset: Int) -> URL? {
        
        if let url = NSURL(string: url) {
            if UIApplication.shared.canOpenURL(url as URL) == false {
                return nil
            }
        }
        
        var baseUrl = URLComponents(string: url)!
        baseUrl.query = ""
        baseUrl.queryItems?.append(contentsOf: [URLQueryItem(name: "limit", value: "50")])
        baseUrl.queryItems?.append(contentsOf: [URLQueryItem(name: "ts", value: K.ts)])
        baseUrl.queryItems?.append(contentsOf: [URLQueryItem(name: "apikey", value: K.publicApi)])
        baseUrl.queryItems?.append(contentsOf: [URLQueryItem(name: "hash", value: K.hash)])
        baseUrl.queryItems?.append(contentsOf: [URLQueryItem(name: "offset", value: String(offset))])

        let url = baseUrl.url
        
        return url
    }
}
