//
//  File.swift
//  
//
//  Created by Lucas Paim on 22/05/21.
//

import Foundation

protocol Database {
    associatedtype Entity: DBEntity
    
    func add(objects: [Entity])
    func update(objects: [Entity])
    func remove(objects: [Entity])
    func query(query: NSPredicate?) -> [Entity]
}

