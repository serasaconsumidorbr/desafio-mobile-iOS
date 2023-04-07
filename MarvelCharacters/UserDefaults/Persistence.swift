//
//  Persistence.swift
//  MarvelCharacters
//
//  Created by Gabriel Beltrame Silva on 06/04/23.
//

import Foundation

class Persistence: PersistenceProtocol {
    
    private let userDefaults: UserDefaults
    
    static let shared = Persistence(userDefaults: UserDefaults.standard)
    
    public init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    func erase<PersistableObject: Codable>(_ type: PersistableObject.Type, persistenceKey: String) {
        userDefaults.set(nil, forKey: persistenceKey)
    }
    
    func erase<PersistableObject: Persistable>(_ type: PersistableObject.Type) {
        erase(type, persistenceKey: type.persistenceKey)
    }
    
    func save<PersistableObject: Codable>(_ object: PersistableObject, persistenceKey: String) {
        guard let encoded = try? JSONEncoder().encode(object) else {
            return
        }
        
        userDefaults.set(encoded, forKey: persistenceKey)
    }
    
    func save<PersistableObject: Persistable>(_ object: PersistableObject) {
        save(object, persistenceKey: PersistableObject.persistenceKey)
    }
    
    func load<PersistableObject: Codable>(
        _ type: PersistableObject.Type,
        persistenceKey: String
    ) -> PersistableObject? {
        guard
            let savedObjectData = userDefaults.object(forKey: persistenceKey) as? Data,
            let object = try? JSONDecoder().decode(PersistableObject.self, from: savedObjectData)
        else {
            return nil
        }
        
        return object
    }
    
    func load<PersistableObject: Persistable>(_ type: PersistableObject.Type) -> PersistableObject {
        return load(type, persistenceKey: type.persistenceKey) ?? type.defaultValue
    }
    
    func sync() {
        userDefaults.synchronize()
    }
}
