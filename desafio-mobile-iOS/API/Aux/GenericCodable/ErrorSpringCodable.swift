//
//  ErrorSpringCodable.swift
//  Marvel
//
//  Created by andre mietti on 15/05/21.
//

import Foundation

public struct InvalidParams: Codable {
    let name: String
    let reason: String
}

public struct ResponseError: Error {
    let title: String
    let message: String
    var statusCode: Int = 0


    static func defaultError(title: String? = nil, detail: String? = nil) -> ResponseError {
        return ResponseError(title: title ?? "some thing is wrong",
                             message: detail ?? "")
    }
}

extension ResponseError {
    init(statusCode: Int) {
        self.init(title: "", message: "", statusCode: statusCode)
    }
}

struct ErrorSpringCodable: Codable {
    var detail: String?
    var instance: String?
    var status: Int?
    var title: String?
    var type: String?
    var invalidParams: [InvalidParams]?
}

extension ErrorSpringCodable {
    var asError: ResponseError {

        guard let statusCode = self.status else {
            guard let title = title, let detail = detail else {
                return ResponseError.defaultError()
            }
            return ResponseError.defaultError(title: title, detail: detail)
        }

        let message = (500..<600).contains(statusCode) ? "Error message here" : (self.detail ?? "detail error message here")

        return ResponseError(title: self.title ?? "error title here",
                             message: message)
    }
}
