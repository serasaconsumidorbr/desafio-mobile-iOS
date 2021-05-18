//
//  ResultExtension.swift
//  Marvel
//
//  Created by andre mietti on 16/05/21.
//

import Foundation

public typealias GenericCompletion<T> = (_ result: Swift.Result<T, Error>) -> Void
public typealias GenericResult<T> = (_ result: Swift.Result<T, ResponseError>) -> Void

public extension Swift.Result {

    /// Returns the value if self represents a success, `nil` otherwise.
    var success: Success? {
        switch self {
        case let .success(value):
            return value
        case .failure:
            return nil
        }
    }

    /// Returns the error if self represents a failure, `nil` otherwise.
    var failure: Failure? {
        switch self {
        case .success:
            return nil
        case let .failure(error):
            return error
        }
    }
}
