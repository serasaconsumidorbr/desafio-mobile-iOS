//
//  APIRestProtocol+ExecuteWithEndpointProtocol.swift
//  Marvel
//
//  Created by andre mietti on 15/05/21.
//

import Foundation

extension APIRestProtocol {
    func execute<T: Decodable>(endpoint: EndpointProtocol, completion: @escaping CompletionRequest<T>) {
        endpoint.headers?.forEach { key, value in
            _ = addHeaderValue(value: value, key: key)
        }

        self.execute(method: endpoint.method, .json, nil, endPoint: endpoint.url, params: endpoint.params, payload: endpoint.data, completion: completion)
    }
}
