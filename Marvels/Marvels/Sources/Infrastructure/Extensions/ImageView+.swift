//
//  ImageView+.swift
//  Marvels
//
//  Created by Moacir Ezequiel Lamego on 24/05/2022.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func load(withUrl urlString : String) {
        if let url = URL(string: urlString){
            let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(style: .medium)
            
            addSubview(activityIndicator)
            activityIndicator.color = .yellow
            
            activityIndicator.startAnimating()
            activityIndicator.center = self.center
            
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                            activityIndicator.removeFromSuperview()
                        }
                    }
                }
            }
        }
    }
    
    func loadImageUsingCache(withUrl urlString : String) {
        let url = URL(string: urlString)
        if url == nil {return}
        self.image = nil

        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString)  {
            self.image = cachedImage
            return
        }

        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(style: .large)
    
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.center = self.center

        // if not, download image from url
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }

            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                    activityIndicator.removeFromSuperview()
                }
            }

        }).resume()
    }
}
