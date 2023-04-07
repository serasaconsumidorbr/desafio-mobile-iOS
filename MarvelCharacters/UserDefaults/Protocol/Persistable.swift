//
//  Persistable.swift
//  MarvelCharacters
//
//  Created by Gabriel Beltrame Silva on 06/04/23.
//

public protocol Persistable: Codable {
    static var persistenceKey: String { get }
    static var defaultValue: Self { get }
}

public extension Persistable {
    static var persistenceKey: String {
        return String(describing: self)
    }
}
