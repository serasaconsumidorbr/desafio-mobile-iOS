//
//  File.swift
//  
//
//  Created by Lucas Paim on 22/05/21.
//

import Foundation


protocol DBEntity {
    associatedtype DomainType: Domain
    func toDomain() -> DomainType
}
