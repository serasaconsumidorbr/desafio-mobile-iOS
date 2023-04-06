//
//  PersistenceClient.swift
//  MarvelCharacters
//
//  Created by Gabriel Beltrame Silva on 06/04/23.
//

import Foundation

public protocol PersistenceProtocol: AnyObject {
    func erase<PersistableObject: Codable>(_ type: PersistableObject.Type, persistenceKey: String)
    
    func erase<PersistableObject: Persistable>(_ type: PersistableObject.Type)
    
    func save<PersistableObject: Codable>(_ object: PersistableObject, persistenceKey: String)
    
    func save<PersistableObject: Persistable>(_ object: PersistableObject)
    
    func load<PersistableObject: Codable>(
        _ type: PersistableObject.Type,
        persistenceKey: String
    ) -> PersistableObject?
    
    func load<PersistableObject: Persistable>(_ type: PersistableObject.Type) -> PersistableObject
    
    func sync()
}
