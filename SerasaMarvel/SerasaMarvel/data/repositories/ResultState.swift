//
//  ResultState.swift
//  SerasaMarvel
//
//  Created by Tito Albino Evangelista da Silva Junior on 25/06/21.
//

import Foundation

enum ResultState {
    case loading
    case success(content: [Character])
    case failed(error: Error)
}
