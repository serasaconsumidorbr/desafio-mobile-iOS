//
//  File.swift
//  
//
//  Created by Lucas Paim on 23/05/21.
//

import Foundation


public struct CharacterListParameters : Encodable {
    public init(nameStartsWith: String? = nil, offset: Int? = nil) {
        self.nameStartsWith = nameStartsWith
        self.offset = offset
    }
    
    public let nameStartsWith: String?
    public let offset: Int?
}
