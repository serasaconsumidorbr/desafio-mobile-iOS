//
//  URLComponents+setQueryitems.swift
//  CharactersMarvel
//
//  Created by Tito Albino Evangelista da Silva Junior on 26/06/21.
//

import Foundation

extension URLComponents {
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}
