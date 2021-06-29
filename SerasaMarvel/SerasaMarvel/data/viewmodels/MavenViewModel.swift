//
//  BoardingViewModel.swift
//  SerasaMarvel
//
//  Created by Tito Albino Evangelista da Silva Junior on 25/06/21.
//

import Foundation
import Combine

protocol MavenViewModelImpl {
    
    func getAllCharacters(page: Int?)
    
}

class MavenViewModel : ObservableObject, MavenViewModelImpl {
    
    private let repository : MavenRepository
    private var subscriptions : Set<AnyCancellable> = .init()
    private(set) var totalItensOfList : Int? = nil
    private(set) var characters = [Character]()
    
    @Published private(set) var state : ResultState = .loading
    
    init(repository : MavenRepository) {
        self.repository = repository
    }
    
    func getAllCharacters(page: Int?) {
        
        self.state = .loading
        
        if let _totalItensOfList = totalItensOfList {
            if self.characters.count >= _totalItensOfList {
                self.state = .failed(error: APIError.errorMesage("Todos os itens carregados."))
                return
            }
        }
        
        repository
            .getAllCharacters(page: page)
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
                self?.totalItensOfList = response.total
                if let data = response.results {
                    self?.characters.append(contentsOf: data)
                }
            }.store(in: &subscriptions)
    }
    
}
