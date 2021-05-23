//
//  File.swift
//  
//
//  Created by Lucas Paim on 22/05/21.
//

import Foundation
import RealmSwift


final class DBCharacter: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String? = nil
    @objc dynamic var picture: String? = nil
    @objc dynamic var characterDescription: String? = nil
    @objc dynamic var thumbnail: String? = nil
    
    override class func primaryKey() -> String? { "id" }
}

// MARK: DBEntity Definition
extension DBCharacter: DBEntity {

    typealias DomainType = Character
    
    func toDomain() -> Character {
        return Character(
            id: id,
            name: name,
            picture: picture,
            description: characterDescription,
            thumbnail: thumbnail
        )
    }
}
