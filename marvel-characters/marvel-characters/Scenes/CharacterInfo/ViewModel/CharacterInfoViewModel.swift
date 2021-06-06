//
//  CharacterInfoViewModel.swift
//  marvel-characters
//
//  Created by Paulo Atavila on 05/06/21.
//

import Foundation

protocol CharacterInfoViewModelProtocol {
    var selectedCharacter: Character { get }
    var sections: [CharacterInfoSectionHeader] { get }
    func getNumberOfSections() -> Int
    func getSectionAt(_ index: Int) -> CharacterInfoSectionHeader?
    func toggleSectionAt(_ index: Int)
    func getNumberOfRowInSection(_ section: Int) -> Int
    func getItemAt(_ indexPath: IndexPath) -> CharacterInfo?
}

class CharacterInfoViewModel: CharacterInfoViewModelProtocol{
    let selectedCharacter: Character
    var sections: [CharacterInfoSectionHeader]
    
    init(character: Character) {
        selectedCharacter = character
        sections = []
        setSections()
    }
    
    private func setSections() {
        var section = 0
        if let text = selectedCharacter.characterDescription, !text.isEmpty {
            sections.append(CharacterInfoSectionHeader(type: .description, section: section))
            section += 1
        }
        if selectedCharacter.comics?.returned ?? 0 > 0 {
            sections.append(CharacterInfoSectionHeader(type: .comics, section: section))
            section += 1
        }
        if selectedCharacter.series?.returned ?? 0 > 0 {
            sections.append(CharacterInfoSectionHeader(type: .series, section: section))
            section += 1
        }
        if selectedCharacter.stories?.returned ?? 0 > 0 {
            sections.append(CharacterInfoSectionHeader(type: .stories, section: section))
            section += 1
        }
        if selectedCharacter.events?.returned ?? 0 > 0 {
            sections.append(CharacterInfoSectionHeader(type: .events, section: section))
            section += 1
        }
        if selectedCharacter.urls?.count ?? 0 > 0 {
            sections.append(CharacterInfoSectionHeader(type: .urls, section: section))
            section += 1
        }
    }
    
    func getNumberOfSections() -> Int {
        return sections.count
    }
    
    func getSectionAt(_ index: Int) -> CharacterInfoSectionHeader? {
        guard index >= 0, index < sections.count else {
            return nil
        }
        return sections[index]
    }
    
    func toggleSectionAt(_ index: Int) {
        guard index >= 0, index < sections.count else {
            return
        }
        sections[index].isOpen.toggle()
    }
    
    func getNumberOfRowInSection(_ section: Int) -> Int {
        guard let section = getSectionAt(section) else {
            return 0
        }
        if !section.isOpen {
            return 0
        }
        switch section.type {
        case .description:
            return 1
        case .comics:
//            let available = selectedCharacter.comics?.available ?? 0
//            let returned = selectedCharacter.comics?.returned ?? 0
//            return returned < available ? returned + 1 : returned
            return selectedCharacter.comics?.returned ?? 0
        case .series:
            return selectedCharacter.series?.returned ?? 0
        case .stories:
            return selectedCharacter.stories?.returned ?? 0
        case .events:
            return selectedCharacter.events?.returned ?? 0
        case .urls:
            return selectedCharacter.urls?.count ?? 0
        }
    }
    
    func getItemAt(_ indexPath: IndexPath) -> CharacterInfo? {
        guard let section = getSectionAt(indexPath.section) else {
            return nil
        }
        let seeMore: CharacterInfo = CharacterInfo(title: nil, type: .button)
        switch section.type {
        case .description:
            return CharacterInfo(title: selectedCharacter.characterDescription, type: .text)
        case .comics:
//            if indexPath.row >= selectedCharacter.comics?.returned ?? 0 - 1 {
//                return seeMore
//            }
            guard let item = selectedCharacter.comics?.items?[indexPath.row] else {
                return nil
            }
            return CharacterInfo(title: item.name, type: .text)
        case .series:
            guard let item = selectedCharacter.series?.items?[indexPath.row] else {
                return nil
            }
            return CharacterInfo(title: item.name, type: .text)
        case .stories:
            guard let item = selectedCharacter.stories?.items?[indexPath.row] else {
                return nil
            }
            return CharacterInfo(title: item.name, type: .text)
        case .events:
            guard let item = selectedCharacter.events?.items?[indexPath.row] else {
                return nil
            }
            return CharacterInfo(title: item.name, type: .text)
        case .urls:
            guard let item = selectedCharacter.urls?[indexPath.row] else {
                return nil
            }
            return CharacterInfo(title: "Link to: \(item.type ?? "")", type: .text)
        }
    }
}
