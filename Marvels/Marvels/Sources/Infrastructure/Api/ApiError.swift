//
//  ApiError.swift
//  Marvels
//
//  Created by Moacir Ezequiel Lamego on 23/05/2022.
//

import Foundation

public enum ApiErrorCode: Int {
    case serverErrorStatusCode = 500
}

public enum KnownApiFailures: Error {
    case serverErrorStatusCode(Error)
}

public enum ApiError: Error {
    case failure (Error, Int)
    case invalidResponse(Int)
    case emptyResponse
    case unknownError(Int)
}
