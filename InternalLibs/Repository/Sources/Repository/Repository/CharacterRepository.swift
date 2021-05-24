//
//  CharacterRepository.swift
//  
//
//  Created by Lucas Paim on 22/05/21.
//

import Foundation
import Network
import PromiseKit

public protocol CharacterRepository {
    func fetchCharacterList(parameters: CharacterListParameters) -> Promise<Paginated<Character>>
    func fetchCharacterById(id: Int) -> Character?
}

final class CharacterRepositoryImpl: CharacterRepository {
    
    var characterService: CharacterService?
    var characterDatabase: CharacterDatabase?
    
    public init(characterService: CharacterService?, characterDatabase: CharacterDatabase?) {
        self.characterService = characterService
        self.characterDatabase = characterDatabase
    }
    
    
    func fetchCharacterList(parameters: CharacterListParameters) -> Promise<Paginated<Character>> {
        guard let service = characterService,
              let database = characterDatabase else { return Promise(error: RepositoryErrors.invalidService) }
        
//        return Promise<Paginated<Character>> { seal in
//            seal.fulfill(Paginated(offset: 0, total: 100, count: 20, results: database.query().map { $0.toDomain() } ))
//        }
        
        return service.request(parameters: parameters)
            .map { $0.data }
            .map { ($0.offset, $0.total, $0.count, $0.results.map { item in self.convertToInternal(character: item) } ) }
            .map { item -> (Int, Int, Int, [DBCharacter]) in
                database.add(objects: item.3)
                return item
            }
            .map { item -> Paginated<Character> in
                Paginated<Character>(
                    offset: item.0,
                    total: item.1,
                    count: item.2,
                    results: item.3.map { $0.toDomain() }
                )
            }
    }
    
    func fetchCharacterById(id: Int) -> Character? {
        guard let database = characterDatabase else { return nil }
        let result = database.query(query: NSPredicate(format: "id = %d", id))
        return result.first?.toDomain()
    }
    
    func convertToInternal(character: CharacterResponse) -> DBCharacter {
        let dbCharacter = DBCharacter()
        dbCharacter.id = character.id
        dbCharacter.characterDescription = character.description
        dbCharacter.name = character.name
        dbCharacter.thumbnail = "\(character.thumbnail.path).\(character.thumbnail.extension)"
        return dbCharacter
    }
}
