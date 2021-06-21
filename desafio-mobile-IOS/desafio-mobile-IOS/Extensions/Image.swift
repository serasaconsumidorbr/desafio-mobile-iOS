//
//  ImageView.swift
//  desafio-mobile-IOS
//
//  Created by Gustavo  Feliciano Figueiredo on 21/06/21.
//

import Foundation
import UIKit

extension UIImage{
    static func loadImageWithURL(from url: URL, completion: @escaping (Result<UIImage, Error>)->Void){
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url){
                if let image = UIImage(data: data) {
                    completion(.success(image))
                }else{
                    completion(.failure(GenericError.cantUnwrap))
                }
            }else{
                completion(.failure(MarvelAPIError.cantMakeRequest))
            }
        }
    }
}
