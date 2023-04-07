//
//  PersistenceTests.swift
//  MarvelCharactersTests
//
//  Created by Gabriel Beltrame Silva on 07/04/23.
//

import Foundation
import Nimble
import XCTest
@testable import MarvelCharacters

final class PersistenceTests: XCTestCase {

    func testPersistable() {
        let userDefaultsMock = UserDefaultsMock()
        let persistence = Persistence(userDefaults: userDefaultsMock)
        
        expect(persistence.load(MockPersistable.self))
            .toEventually(equal(MockPersistable.defaultValue))
        
        let persistable = MockPersistable(string: "Test Save and Load Persistable")
        
        persistence.save(persistable)
        persistence.sync()
        
        expect(persistence.load(MockPersistable.self))
            .to(equal(persistable))
        
        persistence.erase(MockPersistable.self)
        persistence.sync()
        
        expect(persistence.load(MockPersistable.self))
            .to(equal(MockPersistable.defaultValue))
    }
    
    func testCodable() {
        let userDefaultsMock = UserDefaultsMock()
        let persistence = Persistence(userDefaults: userDefaultsMock)
        
        expect(persistence.load(MockCodable.self, persistenceKey: "CustomPersistenceKey"))
            .to(beNil())
        
        let codable = MockCodable(string: "Test Save and Load Codable")
        
        persistence.save(codable, persistenceKey: "CustomPersistenceKey")
        persistence.sync()
        
        expect(persistence.load(MockCodable.self, persistenceKey: "WrongKey"))
            .to(beNil())
        
        expect(persistence.load(MockCodable.self, persistenceKey: "CustomPersistenceKey"))
            .to(equal(codable))
        
        persistence.erase(MockCodable.self, persistenceKey: "WrongKey")
        persistence.sync()
        
        expect(persistence.load(MockCodable.self, persistenceKey: "CustomPersistenceKey"))
            .to(equal(codable))
        
        persistence.erase(MockCodable.self, persistenceKey: "CustomPersistenceKey")
        persistence.sync()
        
        expect(persistence.load(MockCodable.self, persistenceKey: "CustomPersistenceKey"))
            .to(beNil())
    }
    
    fileprivate struct MockCodable: Codable, Equatable {
        let string: String
    }
    
    fileprivate struct MockPersistable: Persistable, Equatable {
        let string: String
        
        static var defaultValue: MockPersistable {
            return MockPersistable(string: "Default Value")
        }
    }
}
