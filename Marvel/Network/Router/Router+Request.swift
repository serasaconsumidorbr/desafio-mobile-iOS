//
//  Router+Request.swift
//  Marvel
//
//  Created by João Pedro on 21/01/21.
//


import UIKit
import Alamofire
import PromiseKit

extension Router {
    public func request<T: Codable>(
        from route: EndPoint,
        responseType: T.Type
    ) -> Promise<T> {

        return Promise { seal in

            if !NetworkConnectivity.isConnectedToInternet {
                seal.reject(HTTPError(cause: .internetConectionFailed, endpoint: route, status: nil))
                return
            }

            var headers: [String: String] = route.sharedHeader
            if let headersRequest = route.headers {
                headers.update(other: headersRequest.dictionary)
            }

            let url = route.path.isEmpty ? route.baseURL : route.baseURL.appendingPathComponent(route.path)

            HTTPCookieStorage.shared.cookies?.forEach { HTTPCookieStorage.shared.deleteCookie($0) }
            URLCache.shared.removeAllCachedResponses()

            let request = manager.request(
                url,
                method: route.httpMethod,
                parameters: route.parameters,
                encoding: route.encoding,
                headers: HTTPHeaders(headers)
            )

            request.responseJSON { [weak self] data in
                self?.log(request: data.request)
                self?.handleServerResponse(route: route,
                                           responseType: responseType,
                                           seal: seal,
                                           response: data,
                                           request: request)
            }
        }
    }
}
