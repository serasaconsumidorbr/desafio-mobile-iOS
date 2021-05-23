//
//  File.swift
//  
//
//  Created by Lucas Paim on 23/05/21.
//

import Foundation

public struct Paginated<T: Domain> {
    let offset: Int
    let total: Int
    let count: Int
    let results: [T]
}
