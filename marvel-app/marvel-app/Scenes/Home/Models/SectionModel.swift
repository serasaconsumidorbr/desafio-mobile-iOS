//
//  SectionModel.swift
//  Marvel Characters
//
//  Created by Leonardo Bandeira on 31/01/23.
//

import Foundation

struct SectionModel {
    let section: Section
    let characters: [Character]?
    
    var numberOfRows: Int {
        switch section {
        case .carousel:
            return 1
        case .list:
            return characters?.count ?? 0
        }
    }
    
    enum Section {
        case carousel, list
    }
}
