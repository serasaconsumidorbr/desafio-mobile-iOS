//
//  File.swift
//  
//
//  Created by Lucas Paim on 23/05/21.
//

import Foundation


public final class ResponseWrapper<T: Decodable>: Decodable {
    public let code: Int
    public let copyright: String    
    public let data: T
}


public final class PaginationWrapper<T: Decodable>: Decodable {
    public let offset: Int
    public let limit: Int
    public let total: Int
    public let count: Int
    public let results: [T]
}


public final class URL: Decodable {
    public let type: String
    public let url: String
}

public final class Image: Decodable {
    public let path: String
    public let `extension`: String
}
