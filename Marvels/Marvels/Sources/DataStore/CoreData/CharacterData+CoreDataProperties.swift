//
//  CharacterData+CoreDataProperties.swift
//  
//
//  Created by Moacir Ezequiel Lamego on 25/05/2022.
//
//

import Foundation
import CoreData


extension CharacterData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CharacterData> {
        return NSFetchRequest<CharacterData>(entityName: "CharacterData")
    }

    @NSManaged public var uid: Int64
    @NSManaged public var name: String?
    @NSManaged public var about: String?
    @NSManaged public var thunbnailCarousel: String?
    @NSManaged public var thunbnailList: String?

}
