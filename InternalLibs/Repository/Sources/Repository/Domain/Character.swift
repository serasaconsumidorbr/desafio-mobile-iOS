//
//  File.swift
//  
//
//  Created by Lucas Paim on 22/05/21.
//

import Foundation

struct Character: Domain {
    
    public init(
        id: Int = 0, name: String? = nil,
        picture: String? = nil,
        description: String? = nil,
        thumbnail: String? = nil
    ) {
        self.id = id
        self.name = name
        self.picture = picture
        self.description = description
        self.thumbnail = thumbnail
    }
    
    public var id: Int = 0
    public var name: String? = nil
    public var picture: String? = nil
    public var description: String? = nil
    public var thumbnail: String? = nil
}

