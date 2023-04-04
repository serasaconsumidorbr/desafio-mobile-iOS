//
//  NetworkClientProtocol.swift
//  MarvelCharacters
//
//  Created by Gabriel Beltrame Silva on 03/04/23.
//

import Foundation

public protocol NetworkClientProtocol {
    func makeRequest<T: Decodable>(
        to endpoint: EndpointConvertible,
        of type: T.Type,
        completion: @escaping (_ result: Result<T, Error>) -> ()
    )
}
