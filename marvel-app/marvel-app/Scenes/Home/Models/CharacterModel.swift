//
//  CharacterModel.swift
//  Marvel Characters
//
//  Created by Leonardo Bandeira on 30/01/23.
//

import Foundation

struct Character: Decodable {
    let name: String?
    let description: String?
    let thumbnail: CharacterImage?
    
    struct CharacterImage: Decodable {
        let path: String?
        let `extension`: String?
        
        var url: URL? {
            let httpsPath = path?.replacingOccurrences(of: "http", with: "https") ?? String()
            return URL(string: "\(httpsPath).\(`extension` ?? String())")
        }
    }
}
