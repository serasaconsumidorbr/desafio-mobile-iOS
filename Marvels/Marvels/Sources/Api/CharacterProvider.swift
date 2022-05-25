//
//  CharacterProvider.swift
//  Marvels
//
//  Created by Moacir Ezequiel Lamego on 23/05/2022.
//

import Foundation

typealias CharacterAPICompletionHandler = (Result<CharacterModel, Error>) -> Void
typealias CharacterDataStoreCompletionHandler = (CharacterDataStore) -> Void
public typealias CompletionData = (statusCode: Int, data: Data)
public typealias CompletionCallBack = (@escaping () throws -> CompletionData) -> Void

protocol CharacterProviderProtocol {
    func request(parameters: [AnyHashable: Any], completion: @escaping CompletionCallBack)
}

final class CharacterProvider: CharacterProviderProtocol {
    func request(parameters: [AnyHashable : Any], completion: @escaping CompletionCallBack) {
        let params = parameters[Constants.MarvelApi.params] as! String
        
        let urlStr = "\(Constants.MarvelApi.urlBase)\(params)"

        debugPrint(urlStr)
        
        let urlRequest = NSMutableURLRequest(url: URL(string: urlStr)!)
        urlRequest.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: urlRequest as URLRequest) { (data, response, error) in
            do {
                let statusCode = (response as? HTTPURLResponse)?.statusCode
                let myResponse = MyResponse(data: data, error: error, statusCode: statusCode, success: false)
                
                if let error = error {
                    debugPrint(error)
                    completion { try self.handlerresponse(myResponse) }
                }
                
                if data != nil {
               //     data?.toPrettyJSON()
                    completion { try self.handlerresponse(myResponse) }
                } else {
                    debugPrint("Error ao Executar uma chamda de API")
                    completion { try self.handlerresponse(myResponse) }
                }
            }
        }
        
        task.resume()
    }
    
    private func handlerresponse(_ myResponse: MyResponse?) throws -> CompletionData! {
        guard let response = myResponse else {
            throw ApiError.emptyResponse
        }

        if response.error != nil {
            try self.handlerError(error: response.error!, statuscode: response.statusCode)
        }

        switch response.statusCode {
        case 200...299:
            if let data = response.data {
                return (response.statusCode, data)
            }
            
            throw ApiError.invalidResponse(response.statusCode)
        default:
            throw ApiError.unknownError(response.statusCode)
        }
    }
    
    private func handlerError(error: Error, statuscode: Int) throws  {
        if let errorCode = ApiErrorCode(rawValue: error._code) {
            switch errorCode {
            case .serverErrorStatusCode:
                throw KnownApiFailures.serverErrorStatusCode(error)
            }
        }

        throw ApiError.failure(error, statuscode)
    }
}
