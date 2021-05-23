//
//  File.swift
//  
//
//  Created by Lucas Paim on 22/05/21.
//

import Foundation
import RealmSwift


class RealmDatabase<T>: Database
        where T: Object & DBEntity {
    
    typealias Entity = T
    
    // Just an shortcut
    var realm: Realm? {
        DBRealm.instance.realm
    }
    
    func add(objects: [T]) {
        guard let realm = realm else { return }
        try? realm.write() {
            realm.add(objects, update: .modified)
        }
    }
    
    func update(objects: [T]) {
        guard let realm = realm else { return }
        try? realm.write() {
            realm.add(objects, update: .modified)
        }
    }
    
    func remove(objects: [T]) {
        guard let realm = realm else { return }
        try? realm.write() {
            realm.delete(objects)
        }
    }
    
    func query(query: NSPredicate? = nil) -> [T] {
        guard let realm = realm else { return [] }
        var result = realm.objects(T.self)
        if let filter = query {
            result = result.filter(filter)
        }
        return result.map { $0 }
    }
    
}
