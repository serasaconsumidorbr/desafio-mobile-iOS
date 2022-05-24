//
//  CharacterViewModel.swift
//  Marvels
//
//  Created by Moacir Ezequiel Lamego on 23/05/2022.
//

import Foundation
import UIKit

struct CharacterViewModel {
    var model: CharacterModel?
    
    init(model: CharacterModel) {
        self.model = model
    }
    
    init() {
//        self.model = CharacterModel()
    }
    
    func getName(row: Int) -> String {
        model?.data?.results?[row].name ?? ""
    }
    
    func getDescription(row: Int) -> String {
        model?.data?.results?[row].resultDescription ?? ""
    }
    
    func getThumbnail(row: Int) -> String {
        if model?.data?.results?[row].thumbnail?.path.count ?? 0 > 0 {
            let ext = model?.data?.results?[row].thumbnail?.thumbnailExtension?.rawValue ?? ""
            let path = model?.data?.results?[row].thumbnail?.path ?? ""
            return "\(path).\(ext)"
        }
        
        return ""
    }
    
    func request(completionHandler: @escaping CharacterAPICompletionHandler) {
        let resource = Constants.MarvelApi.resource
        let apiKey = "\(Constants.MarvelApi.apiKey)=\(Constants.Credentials.apiPublicKey)"
        let hash = "\(Constants.MarvelApi.hash)=\(Constants.Credentials.hash)"
        let ts = "\(Constants.MarvelApi.timeStamp)=\(Constants.Credentials.timeStamp)"
        let limit = "\(Constants.MarvelApi.limit)=10"
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
