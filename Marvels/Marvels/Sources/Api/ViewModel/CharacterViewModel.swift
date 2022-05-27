//
//  CharacterViewModel.swift
//  Marvels
//
//  Created by Moacir Ezequiel Lamego on 23/05/2022.
//

import Foundation
import UIKit

enum ImageVariants: String {
    case portrait_small
    case portrait_medium
    case portrait_xlarge
    case portrait_fantastic
    case portrait_uncanny
    case portrait_incredible
    
    case landscape_small
    case landscape_medium
    case landscape_large
    case landscape_xlarge
    case landscape_amazing
    case landscape_incredible
}

struct CharacterViewModel {
    var dataStore: CharacterDataStore?
    
    init(dataStore: CharacterDataStore) {
        self.dataStore = dataStore
    }
    
    init() {
        self.dataStore = CharacterDataStore()
    }
    
    func getName(row: Int) -> String {
        dataStore?.items?[row].name ?? ""
    }
    
    func getDescription(row: Int) -> String {
        dataStore?.items?[row].about ?? ""
    }
    
    func getThumbnailCarousel(row: Int) -> String {
        dataStore?.items?[row].thunbnailCarousel ?? ""
    }
    
    func getThumbnailList(row: Int) -> String {
        dataStore?.items?[row].thunbnailList ?? ""
    }
    
    func request(completionHandler: @escaping CharacterDataStoreCompletionHandler) {
        let characterDataStore = CharacterDataStore()
        characterDataStore.getAllItems()

        let resource = Constants.MarvelApi.resource
        let apiKey = "\(Constants.MarvelApi.apiKey)=\(Constants.Credentials.apiPublicKey)"
        let hash = "\(Constants.MarvelApi.hash)=\(Constants.Credentials.hash)"
        let ts = "\(Constants.MarvelApi.timeStamp)=\(Constants.Credentials.timeStamp)"
        let limit = "\(Constants.MarvelApi.limit)=100"
        let params = "\(resource)&\(apiKey)&\(hash)&\(ts)&\(limit)"
        
        let parameters: [AnyHashable: Any] = [Constants.MarvelApi.params: params]
        let provider = CharacterProvider()
        
        provider.request(parameters: parameters) { result in
            do {
                let result = try result()
                let apiResponse = try JSONDecoder().decode(CharacterModel.self, from: result.data)
                
                characterDataStore.createItem(withModel: apiResponse) { characterDataStore in
                    completionHandler(characterDataStore)
                }
            } catch {
                debugPrint(error)
                completionHandler(characterDataStore)
            }
        }
    }
}
