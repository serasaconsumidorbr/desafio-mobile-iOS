//
//  NetworkClient.swift
//  MarvelCharacters
//
//  Created by Gabriel Beltrame Silva on 03/04/23.
//

import Alamofire

class NetworkClient: NetworkClientProtocol {
    
    static let shared = NetworkClient()
    
    let sessionManager: Session
    
    init(sessionManager: Session = Session(configuration: URLSessionConfiguration.af.default)) {
        self.sessionManager = sessionManager
    }
    
    func makeRequest<T: Decodable>(
        to endpoint: EndpointConvertible,
        of type: T.Type = T.self,
        completion: @escaping (_ result: Result<T, Error>) -> ()
    ) {
        var parameters = endpoint.authenticationParameters
        
        if let additionalParameters = endpoint.additionalParameters {
            parameters?.merge(additionalParameters, uniquingKeysWith: { (current, _) in current })
        }
        
        sessionManager.request(
            endpoint.convertible,
            method: endpoint.method,
            parameters: parameters,
            encoding: endpoint.encoding,
            headers: endpoint.headers
        ).responseDecodable(of: type) { response in
            if let decodedObject = response.value {
                completion(.success(decodedObject))
            } else if let error = response.error {
                completion(.failure(error))
            }
        }
    }
}
