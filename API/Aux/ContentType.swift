//
//  ContentType.swift
//  Marvel
//
//  Created by andre mietti on 15/05/21.
//

import Foundation

protocol ContentTypeBodyFunctions {
    func createDataBodyFormData(withParameters params: [String: Any]) -> Data
    func createDataBodyJsonData(withParameters params: [String: Any]) throws -> Data
    func generateBoundary() -> String
}

enum ContentType {

    case formurlencoded
    case json
    case formdata
    case image

    func contentType(_ boundary: String? = nil) -> String {
        switch self {
        case .formdata:
            return "multipart/form-data; boundary=\(boundary.defaultValue)"
        case .formurlencoded:
            return "application/x-www-form-urlencoded"
        case .json:
            return "application/json"
        case .image:
            return "image/*"
        }
    }

}

class ContentTypeFunctions: ContentTypeBodyFunctions {

    var boundary: String = "-----------------------\(UUID().uuidString)"

    func createDataBodyFormData(withParameters params: [String: Any]) -> Data {
        let body = NSMutableData()

        let boundaryPrefix = "--\(boundary)\r\n"

        for (key, value) in params {
            body.appendString(boundaryPrefix)
            body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString("\(value)\r\n")
        }
        body.appendString("--".appending(boundary.appending("--")))

        return body as Data
    }

    func createDataBodyJsonData(withParameters params: [String: Any]) throws -> Data {
        let data = try JSONSerialization.data(withJSONObject: params, options: [])
        return data
    }

    func generateBoundary() -> String {
        return self.boundary
    }
}

extension NSMutableData {
    func appendString(_ string: String) {
        if let data = string.data(using: .utf8, allowLossyConversion: false) {
            append(data)
        }
    }
}
