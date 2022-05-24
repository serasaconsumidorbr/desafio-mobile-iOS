//
//  CharacterViewModel.swift
//  Marvels
//
//  Created by Moacir Ezequiel Lamego on 23/05/2022.
//

import Foundation

struct CharacterViewModel {
    var model: CharacterView?
    
    init(model: CharacterView) {
        self.model = model
    }
    
    init() {
        self.model = CharacterView()
    }
    
    func request(completionHandler: @escaping CharacterAPICompletionHandler) {
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
                completionHandler(.success(apiResponse))
//                debugPrint(result.data.prettyPrintedJSONString())
            } catch {
                debugPrint(error)
                completionHandler(.failure(error))
            }
        }
    }
}
