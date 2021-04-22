//
//  MarvelPaginatedObject.swift
//  Marvel
//
//  Created by João Pedro on 21/04/21.
//

import Foundation

struct MarvelPaginatedObject<T: Codable>: Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [T]
}
