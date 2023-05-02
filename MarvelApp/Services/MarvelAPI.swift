//
//  MarvelAPI.swift
//  MarvelApp
//
//  Created by Paola Alcantara Soares on 02/05/23.
//

import UIKit
import Foundation
import CryptoKit
import Alamofire


class MarvelApi {
    
    let marvelApi = MarvelApi()
    
    static private let basePath: String = "http://gateway.marvel.com/v1/público/caracteres"
    static private let privateKey: String = "0bb8c5ec904b0718de3984e8db8725bd461c8a04"
    static private let publicKey: String = "d0e8278b6afc43928d44dd60b0e45ae8"
    static private let limit = 50
    
    
    class func loadHeros(name: String?, page: Int = 0, onComplete: @escaping(MarvelInfoModel?) -> Void) {
        let offset = page * limit
        let startsWith: String
        if let name = name, !name.isEmpty {
            startsWith = "NameStartsWith=\(name.replacingOccurrences(of: " ", with: ""))&"
        } else {
            startsWith = ""
        }
        
        let url = basePath + "offset=\(offset)&limit=\(limit)&" + startsWith + getCredentials()
        print(url)
        AF.request(url).responseJSON { (response) in
            guard let data = response.data,
                  let marvelInfo = try? JSONDecoder().decode(MarvelInfoModel.self, from: data),
                  marvelInfo.code == 200 else {
                onComplete(nil)
                return
            }
            onComplete(marvelInfo)
        }
    }
    
    private class func getCredentials() -> String {
        let marvelApi = MarvelApi()
        let ts = String(Date().timeIntervalSince1970)
        let hash = marvelApi.md5(data: "\(ts)\(privateKey)\(publicKey)")
        return "&ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
    }
    
    private func md5(data: String) -> String {
        let hash = Insecure.MD5.hash(data: data.data(using: .utf8) ?? Data())
        return hash.map {
            String(format: "%02hhx", $0)
        }
        .joined()
    }
}





