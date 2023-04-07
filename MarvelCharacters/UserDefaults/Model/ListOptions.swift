//
//  ListOptions.swift
//  MarvelCharacters
//
//  Created by Gabriel Beltrame Silva on 06/04/23.
//

public struct ListOptions: Equatable {
    var listOrder: ListOrder
    var itemsPerPage: Int
}

public enum ListOrder: String, CaseIterable, Equatable {
    case nameIncreasing = "name"
    case nameDecreasing = "-name"
    case modifiedIncreasing = "modified"
    case modifiedDecreasing = "-modified"
    
    init(_ index: Int) {
        switch index {
        case 1:
            self = .nameDecreasing
        case 2:
            self = .modifiedIncreasing
        case 3:
            self = .modifiedDecreasing
        default:
            self = .nameIncreasing
        }
    }
    
    var itemIndex: Int {
        switch self {
        case .nameIncreasing:
            return 0
        case .nameDecreasing:
            return 1
        case .modifiedIncreasing:
            return 2
        case .modifiedDecreasing:
            return 3
        }
    }
    
    var userFriendlyLabel: String {
        switch self {
        case .nameIncreasing:
            return "Nome A > Z"
        case .nameDecreasing:
            return "Nome Z > A"
        case .modifiedIncreasing:
            return "Recente"
        case .modifiedDecreasing:
            return "Antigo"
        }
    }
}

extension ListOptions: Codable { }

extension ListOrder: Codable { }

extension ListOptions: Persistable {
    public static var defaultValue: ListOptions {
        return ListOptions(listOrder: .nameIncreasing, itemsPerPage: 20)
    }
}
