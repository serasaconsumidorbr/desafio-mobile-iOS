//
//  Hero.swift
//  Marvel (iOS)
//
//  Created by Matheus Custódio on 26/07/22.
//

import Foundation
import UIKit


struct HeroListWrapper: Decodable {
    let data: HeroList
}

struct HeroList: Decodable {
    var offset: Int
    var total: Int
    var results: [Hero]
}

struct Hero: Decodable {
    var id: Int
    var name: String
    var description: String
    var thumbnail: ImageUrl
}

struct ImageUrl: Decodable {
    var path: String
    var `extension`: String
}
