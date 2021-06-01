//
//  NetworkImageLoader.swift
//  characterapp
//
//  Created by Denys Galante on 01/06/2021.
//  Copyright © 2021 Denys Galante. All rights reserved.
//

import UIKit

class NetworkImageLoader: UIImageView {

    var imageUrlString: String?
    let imageCache = NSCache<NSString, UIImage>()
    
    func loadImage(from url: URL, completion: ((Error?)-> Void)? = nil) {
        
        self.imageUrlString = url.absoluteString
        self.image = nil
        
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            self.image = cachedImage
            completion?(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion?(error)
                return
            }
            
            guard let data = data else {
                completion?(NSError(domain: "", code: 000, userInfo: nil))
                return
            }
            
            
            DispatchQueue.main.async {
                
                guard let downloadedImage = UIImage(data: data) else {
                    completion?(NSError(domain: "", code: 000, userInfo: nil))
                    return
                }
                
                if (self.imageUrlString?.elementsEqual(url.absoluteString) ?? false) {
                    self.image = downloadedImage
                }
                
                self.imageCache.setObject(downloadedImage, forKey: url.absoluteString as NSString)
                completion?(nil)
            }
            
            }.resume()
    }
    
}
