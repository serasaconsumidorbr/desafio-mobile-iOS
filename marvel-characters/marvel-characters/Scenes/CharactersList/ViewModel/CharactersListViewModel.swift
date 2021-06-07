//
//  CharactersListViewModel.swift
//  marvel-characters
//
//  Created by Paulo Atavila on 05/06/21.
//

import Foundation

protocol CharactersListViewModelProtocol {
    func getCharactersList(comletion: @escaping () -> Void)
    func getNumberOfCharacters() -> Int
    func getCharacterAt(_ index: Int) -> Character?
    func getNumberOfFirstsCharacters() -> Int
    func getFirstsCharacterAt(_ index: Int) -> Character?
    var hasItemsToLoad: Bool { get }
    var isLoadingRequest: Bool { get }
    var lastRequestSuccess: Bool { get }
}

class CharactersListViewModel: CharactersListViewModelProtocol {
    let service: CharactersListServiceProtocol
    let maxNumberOfFirstItems: Int
    private var charactersList: [Character]
    private var firtsCharactersList: [Character]
    private var totalItemsToBeReceived: Int
    private var returnedAmount: Int
    var hasItemsToLoad: Bool {
        let totalReceived = charactersList.count + firtsCharactersList.count
        return totalReceived < totalItemsToBeReceived
    }
    var isLoadingRequest: Bool
    var lastRequestSuccess: Bool
    
    init(service: CharactersListServiceProtocol = CharactersListService()) {
        self.service = service
        lastRequestSuccess = true
        isLoadingRequest = false
        maxNumberOfFirstItems = 5
        totalItemsToBeReceived = 0
        returnedAmount = 0
        
        firtsCharactersList = []
        charactersList = []
    }
    
    func getCharactersList(comletion: @escaping () -> Void) {
        isLoadingRequest = true
        
        service.fetchCharctersList(offset: returnedAmount) { [weak self] result in
            self?.isLoadingRequest = false
            
            switch result {
            case .success(let data):
                self?.lastRequestSuccess = true
                self?.totalItemsToBeReceived = data.data?.total ?? 0
                self?.returnedAmount += data.data?.count ?? 0
                
                if var items = data.data?.results {
                    if self?.firtsCharactersList.count == 0 {
                        self?.firtsCharactersList = Array(items.prefix(5))
                        if items.count > 5 {
                            items.removeSubrange(0...4)
                        } else {
                            items.removeAll()
                        }
                    }
                    self?.charactersList.append(contentsOf: items)
                }
            case .failure(_):
                self?.lastRequestSuccess = false
                self?.charactersList = []
                self?.firtsCharactersList = []
            }
            comletion()
        }
    }
    
    func getNumberOfCharacters() -> Int {
        return charactersList.count
    }
    
    func getCharacterAt(_ index: Int) -> Character? {
        if index >= 0 && index < charactersList.count {
            return charactersList[index]
        }
        return nil
    }
    
    func getNumberOfFirstsCharacters() -> Int {
        return firtsCharactersList.count
    }
    
    func getFirstsCharacterAt(_ index: Int) -> Character? {
        if index >= 0 && index < firtsCharactersList.count {
            return firtsCharactersList[index]
        }
        return nil
    }
}
