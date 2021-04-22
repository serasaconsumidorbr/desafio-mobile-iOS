//
//  Router+Decode.swift
//  Marvel
//
//  Created by João Pedro on 21/01/21.
//

import Alamofire
import PromiseKit
import Foundation

extension Router {
    func parseValue<T: Codable>(data: Data?, responseType: T.Type) throws -> T? {
        // do..catch is for debug proposals
        do {
            let dataToDecode = data ?? Data("{}".utf8)
            return try JSONDecoder().decode(responseType, from: dataToDecode)
        } catch {
            throw error
        }
    }

    func handleServerResponse<T: Codable>(
        route: EndPoint,
        responseType: T.Type,
        seal: Resolver<T>,
        response: AFDataResponse<Any>,
        request: DataRequest? = nil
    ) {

        if let safeRequest = request {
            log(data: response, curl: safeRequest.cURLDescription())
        }

        guard let statusCode = response.response?.statusCode else {
            seal.reject(HTTPError(cause: .noResponse, endpoint: route, status: nil))
            return
        }

        switch statusCode {
        case 200...204:
            if let decodifiedResponse = try? self.parseValue(data: response.data,
                                                             responseType: responseType) {
                    seal.fulfill(decodifiedResponse)
            } else {
                seal.reject(HTTPError(cause: .unableToDecode, endpoint: route, status: statusCode))
            }
        case 400:
            seal.reject(HTTPError(
                cause: .badRequest(headers: response.response?.allHeaderFields),
                endpoint: route,
                status: statusCode
            ))
        case 401:
            seal.reject(HTTPError(cause: .notAuthorized, endpoint: route, status: statusCode))
        case 403:
            seal.reject(HTTPError(cause: .forbidden, endpoint: route, status: statusCode))
        case 404:
            seal.reject(HTTPError(cause: .notFound, endpoint: route, status: statusCode))
        case 408:
            seal.reject(HTTPError(cause: .timeout, endpoint: route, status: statusCode))
        case 409:
            seal.reject(HTTPError(cause: .conflict, endpoint: route, status: statusCode))
        case 410:
            seal.reject(HTTPError(cause: .gone, endpoint: route, status: statusCode))
        case 500...599:
            seal.reject(HTTPError(cause: .serverError, endpoint: route, status: statusCode))
        default:
            seal.reject(HTTPError(cause: .failed, endpoint: route, status: statusCode))
        }
    }
}

// MARK: - Log
extension Router {
    public func log(data: AFDataResponse<Any>, curl: String? = nil) {
        guard data.error == nil else {
            self.logError(data: data, curl: curl)
            return
        }

        if 200...299 ~= data.response!.statusCode {
            self.logSuccess(data: data, curl: curl)
        } else {
            self.logError(data: data, curl: curl)
        }
    }

    public func log(request: URLRequest?) {
        info(" - - - - - - - - - - REQUEST - - - - - - - - - - ")
        info("⚪️ URI: \(nullable: request?.httpMethod) \(nullable: request?.url?.absoluteString)")
        info("⚪️ Headers: \(nullable: request?.allHTTPHeaderFields)")
        info("⚪️ Body: \(nullable: request?.httpBody)")
        info(" - - - - - - - - - - END - - - - - - - - - - ")
    }

    public func logSuccess(data: AFDataResponse<Any>, curl: String? = nil) {
        guard let response = data.response else { return }
        info("\n - - - - - - - - - - RESPONSE - - - - - - - - - - \n")
        info("🔵 URI: \(nullable: data.request?.url?.absoluteString)\n")
        info("🔵 Status code: \(response.statusCode)\n")
        info("🔵 Headers:\n\(nullable: response.allHeaderFields)\n")
        info("🔵 Body:\n\(nullable: try? data.result.get())")
    }

    public func logError(data: AFDataResponse<Any>, curl: String? = nil) {
        guard let response = data.response else { return }
        info("\n - - - - - - - - - - RESPONSE - - - - - - - - - - \n")
        info("🔴 URI: \(nullable: data.request?.url?.absoluteString)\n")
        info("🔴 Status code: \(response.statusCode)\n")
        info("🔴 Headers:\n\(nullable: response.allHeaderFields)\n")
        info("🔴 Body:\n\(nullable: try? data.result.get())\n")
    }

    public func info<T>(_ object: T?) {
        #if DEBUG
        guard let safeObject = object else { return }
        print("\(safeObject)")
        #endif
    }
}
