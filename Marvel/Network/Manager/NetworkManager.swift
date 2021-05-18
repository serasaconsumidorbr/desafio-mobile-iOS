//
//  NetworkManager.swift
//  Marvel
//
//  Created by João Pedro on 21/01/21.
//

import Foundation
import PromiseKit

public struct NetworkManager {
    public let characters = Router<CharactersEndPoint>()

    public init() { }
}
