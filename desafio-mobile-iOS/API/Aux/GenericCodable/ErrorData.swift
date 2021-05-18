//
//  ErrorData.swift
//  Marvel
//
//  Created by andre mietti on 15/05/21.
//

import Foundation

class ErrorData<E: Decodable> {
    var status: Int = 0
    var request: URLRequest?
    var timestamp: Date
    var error: NSError?
    var message: String?
    var errorValue: E?

    init(timestamp: Date, error: NSError?) {
        self.timestamp = timestamp
        self.error = error
    }

    func decode(data: Data) {
        let decoder = JSONDecoder()
        errorValue = try? decoder.decode(E.self, from: data)
    }
}

extension ErrorData {

    var asSafeError: Error {
        guard let error = error else {
            return NSError() as Error
        }
        return error as Error
    }
}
