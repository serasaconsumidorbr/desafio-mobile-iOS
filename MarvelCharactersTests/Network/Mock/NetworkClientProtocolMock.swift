//
//  NetworkClientProtocolMock.swift
//  MarvelCharactersTests
//
//  Created by Gabriel Beltrame Silva on 03/04/23.
//

import Foundation
import MarvelCharacters

class NetworkClientProtocolMock: NetworkClient {
    var calledMethods: [Methods] = []
    
    enum Methods: Equatable {
        static func == (lhs: NetworkClientProtocolMock.Methods, rhs: NetworkClientProtocolMock.Methods) -> Bool {
            switch (lhs, rhs) {
            case (let .makeRequest(lhsEndpoint), let .makeRequest(rhsEndpoint)):
                return lhsEndpoint.isEqualTo(rhsEndpoint)
            }
        }
        
        case makeRequest(endpoint: EndpointConvertible)
    }
    
    override func makeRequest<T: Decodable>(
        to endpoint: any EndpointConvertible,
        of type: T.Type,
        completion: @escaping (_ result: Result<T, Error>) -> ()
    ) {
        calledMethods.append(.makeRequest(endpoint: endpoint))
        super.makeRequest(to: endpoint, of: type, completion: completion)
    }
}
