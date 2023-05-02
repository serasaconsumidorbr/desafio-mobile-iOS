//
//  ModelMarvel.swift
//  MarvelApp
//
//  Created by Paola Alcantara Soares on 02/05/23.
//

import Foundation

struct MarvelInfoModel: Codable {
    var code: Int?
    var status: String?
    var data: MarvelData
}

struct MarvelData: Codable {
    var offSet: Int?
    var limit: Int?
    var total: Int
    var count: Int?
    var results: [Hero]
}

struct Hero: Codable {
    var id: Int?
    var name: String?
    var description: String?
    var thumbnail: Thumbnail
    var urls: [HeroURL]
}

struct Thumbnail: Codable {
    var path: String?
    var ext: String?
    
    var url: String {
        if let path = path, let ext = ext {
            return path + "." + ext
        }
        return ""
    }
    
    enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }
}

struct HeroURL: Codable {
    var type: String?
    var url: String?
}


