//
//  File.swift
//  
//
//  Created by Lucas Paim on 23/05/21.
//

import Foundation

public struct Paginated<T: Domain> {
    public let offset: Int
    public let total: Int
    public let count: Int
    public let results: [T]
}
