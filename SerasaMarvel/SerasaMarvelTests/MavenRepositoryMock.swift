//
//  MavenRepositoryMock.swift
//  SerasaMarvelTests
//
//  Created by Tito Albino Evangelista da Silva Junior on 29/06/21.
//

import Foundation
import Combine
@testable import SerasaMarvel

class MavenRepositoryMock : MavenRepositoryImpl {
    
    private let isFailed : Bool

    init(isFailed: Bool) {
        self.isFailed = isFailed
    }
    
    func getAllCharacters(page: Int?) -> AnyPublisher<Characters, APIError> {
        
        let data = Characters(
            offset: 0,
            limit: 20,
            total: 1493,
            count: 20,
            results: [
                Character(name: "Adam Warlock",
                          thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/a/f0/5202887448860", ext: "jpg"),
                          modified: "2013-08-07T13:49:06-0400"),
                Character(name: "Agent X (Nijo)",
                          thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available", ext: "jpg"),
                          modified: "1969-12-31T19:00:00-0500"),
                Character(name: "Alex Wilder",
                          thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/2/c0/4c00377144d5a", ext: "jpg"),
                          modified: "1969-12-31T19:00:00-0500"),
                
            ])
        
        if isFailed {
            return Fail(error: APIError.errorMesage("Ocorreu um error ao tentar buscar os dados"))
                .eraseToAnyPublisher()
        }
        
        return Just(data)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
    
}
