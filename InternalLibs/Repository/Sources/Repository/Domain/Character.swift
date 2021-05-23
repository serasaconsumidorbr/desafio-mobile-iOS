//
//  File.swift
//  
//
//  Created by Lucas Paim on 22/05/21.
//

import Foundation

public struct Character: Domain {
    
    public init(
        id: Int = 0, name: String,
        description: String? = nil,
        thumbnail: String
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.thumbnail = thumbnail
    }
    
    public var id: Int = 0
    public var name: String
    public var description: String? = nil
    public var thumbnail: String
}

