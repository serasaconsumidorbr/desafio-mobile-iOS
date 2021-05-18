//
//  ResponseData.swift
//  Marvel
//
//  Created by andre mietti on 15/05/21.
//

import Foundation

struct ResponseData<T: Decodable> {
    var status: Int
    var data: T?
    var responseData: Data?
    var request: URLRequest
    var timestamp: Date
}

struct ResponseVoid {
    var status: Int
    var responseData: Data?
    var request: URLRequest
    var timestamp: Date
}
