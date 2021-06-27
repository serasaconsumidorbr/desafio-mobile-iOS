//
//  BoardingViewModel.swift
//  SerasaMarvel
//
//  Created by Tito Albino Evangelista da Silva Junior on 25/06/21.
//

import Foundation
import Combine

protocol MavenViewModelImpl {
    
    func getAllCharacters()
    
}

class MavenViewModel : ObservableObject, MavenViewModelImpl {
    
    private let repository : MavenRepository
    
    private(set) var characters = [Character]()
    private var subscriptions : Set<AnyCancellable> = .init()
    
    @Published private(set) var state : ResultState = .loading
    
    init(repository : MavenRepository) {
        self.repository = repository
    }
    
    func getAllCharacters() {
        
        self.state = .loading
        
        repository
            .getAllCharacters()
            .sink { [weak self] completing in
                switch completing {
                    case .finished:
                        self?.state = .success(content: self!.characters)
                        break
                    case .failure(let error):
                        self?.state = .failed(error: error)
                        break
                }
            } receiveValue: { [weak self] response in
                if let data = response.results { self?.characters = data }
            }.store(in: &subscriptions)
    }
    
}
