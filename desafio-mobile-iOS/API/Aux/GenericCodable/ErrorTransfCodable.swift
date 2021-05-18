//
//  ErrorTransfCodable.swift
//  Marvel
//
//  Created by andre mietti on 15/05/21.
//

import Foundation

struct ErrorTransfCodable: Codable {
    var timestamp: String?
    var status: Int
    var error: Int?
    var message: String?
    var path: String?
}
