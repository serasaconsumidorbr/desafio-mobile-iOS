//
//  File.swift
//  
//
//  Created by Lucas Paim on 23/05/21.
//

import Foundation


public struct CharacterListParameters : Encodable {
    public init(nameStartsWith: String) {
        self.nameStartsWith = nameStartsWith
    }
    
    public let nameStartsWith: String
}
