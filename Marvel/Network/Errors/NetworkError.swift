//
//  NetworkError.swift
//  Marvel
//
//  Created by João Pedro on 21/01/21.
//

import Foundation

/// protocol create
public protocol DefaultError: Error {
    var errorType: ErrorType { get }
    var customErrorMessage: ErrorMessageString { get }
}

/// enum created to help change image from generic error view
public enum ErrorType {
    /// error caused by internet connection
    case internet
    /// error caused by backend problem
    case backend
    /// error caused inside of application
    case inner
}

public struct HTTPError: DefaultError {
    public enum ErrorCause {
        case internetConectionFailed
        case notAuthorized
        case unableToDecode
        case timeout
        case badRequest(headers: [AnyHashable: Any]?)
        case conflict
        case gone
        case forbidden
        case notFound
        case serverError
        case noResponse
        case failed
    }

    public let cause: ErrorCause
    let endpoint: EndPointType?
    let status: Int?

    public var errorType: ErrorType {
        switch cause {
        case .internetConectionFailed:
            return .internet
        case .failed:
            return .inner
        default:
            return .backend
        }
    }

    /// set error message that user sees on screen
    public var customErrorMessage: ErrorMessageString {
         switch cause {
         case .internetConectionFailed:
            return ErrorMessages.withoutInternet
         default:
            return ErrorMessages.serverError
         }
     }
}

public enum NetworkErrorCode: Int {
    // MARK: Client HTTP errors
    case badRequest = 400
    case unauthorized = 401
    case paymentRequired = 402
    case forbbiden = 403
    case notFound = 404
    case methodNotFound = 405
    case notAcceptable = 406
    case proxyAuthenticationRequired = 407
    case requestTimeout = 408
    case conflict = 409
    case gone = 410
    case lengthRequired = 411
    case preconditionFailed = 412
    case payloadTooLarge = 413
    case uriTooLong = 414
    case unsupportedMediaType = 415
    case rangeNotSatisfiable = 416
    case expectationFailed = 417
    case imATeapot = 418
    case misdirectedRequest = 421
    case unprocessableEntity = 422
    case locked = 423
    case failedDependency = 424
    case upgradeRequired = 426
    case preconditionRequired = 428
    case tooManyRequests = 429
    case requestHeaderFieldsTooLarge = 431
    case unavailableForLegalReasons = 451

    // MARK: Server HTTP errors
    case internalServerError = 500
    case notImplemented = 501
    case badGateway = 502
    case serviceUnavailable = 503
    case gatewayTimeout = 504
    case httpVersionNotSupported = 505
    case variantAlsoNegotiates = 506
    case insufficientStorage = 507
    case loopDetected = 508
    case notExtended = 510
    case networkAuthenticationRequired = 511

    // MARK: Others Error's Range NSCoderErrorMinimum(4864) - NSCoderErrorMaximum(4991)

    case failed = 4864
    case noData = 4865
    case unableToDecode = 4866
    case internetConectionFailed = 4867

    // MARK: Biometric ID
    case touchIDNotAvailable = 4991

    var isServerError: Bool {
        NetworkErrorCode.isServerError(value: self.rawValue)
    }

    static public func isServerError(value: Int) -> Bool {
        500...599 ~= value
    }
}
