//
//  MethodHTTP.swift
//  Marvel
//
//  Created by andre mietti on 15/05/21.
//

enum MethodHTTP {
    case GET
    case POST
    case PUT
    case DELETE
    case PATCH

    func verb() -> String {

        switch self {
        case .GET:
            return "GET"
        case .POST:
            return "POST"
        case .PUT:
            return "PUT"
        case .DELETE:
            return "DELETE"
        case .PATCH:
            return "PATCH"

        }
    }

}
