//
//  MarvelObject.swift
//  Marvel
//
//  Created by João Pedro on 21/04/21.
//

import Foundation

struct MarvelObject<T: Codable>: Codable {
    let code: Int
    let status: String
    let copyright: String
    let attributionText: String
    let attributionHTML: String
    let etag: String
    let data: T
}
