//
//  CharacterListDataSource.swift
//  MarvelCharacters
//
//  Created by Gabriel Beltrame Silva on 04/04/23.
//

import Foundation
import UIKit

public class CharacterListDataSource: NSObject {
    
    let interactor: CharacterListInteractorProtocol?
        
    var copyright: String?
    var items: [CharacterListItem]
    var hasPartialCarousell: Bool
    var hasFullCarousell: Bool
    
    public init(
        interactor: CharacterListInteractorProtocol? = nil,
        copyright: String? = nil,
        items: [CharacterListItem] = [.loading],
        hasPartialCarousell: Bool = false,
        hasFullCarousell: Bool = false
    ) {
        self.interactor = interactor
        self.copyright = copyright
        self.items = items
        self.hasPartialCarousell = hasPartialCarousell
        self.hasFullCarousell = hasFullCarousell
    }
    
    func updating(with characterList: CharacterList, shouldPaginate: Bool) {
        
        if !shouldPaginate {
            items = []
            hasPartialCarousell = false
            hasFullCarousell = false
        } else {
            items.removeLast(1)
        }
        
        copyright = characterList.copyright
        
        if hasFullCarousell {
            characterList.characters.forEach({ items.append(.character(character: $0)) })
        } else if hasPartialCarousell, items.count > 0, case let .carousell(characters) = items[0] {
            items.removeLast(1)
            let remainingItemsToFillCarousell = 5 - characters.count
            if characterList.characters.count >= remainingItemsToFillCarousell {
                let carousellItems = characters + Array(characterList.characters[0..<remainingItemsToFillCarousell])
                items.append(.carousell(characters: carousellItems))
                hasFullCarousell = true
                
                if characterList.characters.count > remainingItemsToFillCarousell {
                    characterList.characters[remainingItemsToFillCarousell..<characterList.characters.count].forEach({ items.append(.character(character: $0)) })
                }
            } else {
                let carousellItems = characters + characterList.characters
                items.append(.carousell(characters: carousellItems))
            }
        } else {
            if characterList.characters.count <= 5 {
                hasPartialCarousell = true
                hasFullCarousell = characterList.characters.count == 5
                items.append(.carousell(characters: characterList.characters))
            } else {
                hasPartialCarousell = true
                hasFullCarousell = true
                items.append(.carousell(characters: Array(characterList.characters[0..<5])))
                characterList.characters[5..<characterList.count].forEach({ items.append(.character(character: $0)) })
            }
        }
        if characterList.offset + characterList.count < characterList.total {
            items.append(.loading)
        }
    }
}

extension CharacterListDataSource: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch items[indexPath.row] {
        case .carousell:
            return 480
        case .character:
            return 118
        case .loading:
            return 80
        }
    }
    
}

extension CharacterListDataSource: UITableViewDataSource {

    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch items[indexPath.row] {
        case let .carousell(characters):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CarousellTableViewCell", for: indexPath) as? CarousellTableViewCell else {
                return UITableViewCell()
            }
            cell.updateDataSource(with: characters)

            return cell
        case let .character(character):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell", for: indexPath) as? CharacterTableViewCell else {
                return UITableViewCell()
            }
            cell.fill(with: character)

            return cell
        case .loading:
            // This is not the ideal way of handling the new page loads because we are treating it as a side-effect.
            // Unfortunately time is too short to properly implement the tableView prefetchRow functions.
            interactor?.loadCharactersPage()
            return tableView.dequeueReusableCell(withIdentifier: "LoadingTableViewCell", for: indexPath)
        }
    }
}

extension CharacterListDataSource {
    
    public override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? CharacterListDataSource else {
            return false
        }
        return self == other
    }
    
    public static func == (lhs: CharacterListDataSource, rhs: CharacterListDataSource) -> Bool {
        return (lhs.copyright == rhs.copyright) &&
        (lhs.items == rhs.items) &&
        (lhs.hasPartialCarousell == rhs.hasPartialCarousell) &&
        (lhs.hasFullCarousell == rhs.hasFullCarousell)
    }
}
