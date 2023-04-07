//
//  PersistenceProtocolMock.swift
//  MarvelCharactersTests
//
//  Created by Gabriel Beltrame Silva on 06/04/23.
//

import Foundation
import MarvelCharacters

class PersistenceProtocolMock: PersistenceProtocol {
    
    var calledMethods: [Methods] = []
    
    enum Methods: Equatable {
        case erase(persistenceKey: String)
        case erasePersistable
        case save(persistenceKey: String)
        case savePersistable
        case load(persistenceKey: String)
        case loadPersistable
        case sync
    }
    
    var loadMock: Codable?
    var loadPersistableMock: Persistable?
    
    func erase<PersistableObject: Codable>(_ type: PersistableObject.Type, persistenceKey: String) {
        calledMethods.append(.erase(persistenceKey: persistenceKey))
    }
    
    func erase<PersistableObject: Persistable>(_ type: PersistableObject.Type) {
        calledMethods.append(.erasePersistable)
    }
    
    func save<PersistableObject: Codable>(_ object: PersistableObject, persistenceKey: String) {
        calledMethods.append(.save(persistenceKey: persistenceKey))
    }
    
    func save<PersistableObject: Persistable>(_ object: PersistableObject) {
        calledMethods.append(.savePersistable)
    }
    
    func load<PersistableObject: Codable>(
        _ type: PersistableObject.Type,
        persistenceKey: String
    ) -> PersistableObject? {
        calledMethods.append(.load(persistenceKey: persistenceKey))
        return loadMock as? PersistableObject
    }
    
    func load<PersistableObject: Persistable>(_ type: PersistableObject.Type) -> PersistableObject {
        calledMethods.append(.loadPersistable)
        return (loadPersistableMock as? PersistableObject) ?? type.defaultValue
    }
    
    func sync() {
        calledMethods.append(.sync)
    }
}
