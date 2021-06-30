//
//  UIImageView+loadByUrl.swift
//  SerasaMarvel
//
//  Created by Tito Albino Evangelista da Silva Junior on 27/06/21.
//

import UIKit

extension UIImageView {
    
    func load(url: URL) {
  
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard error == nil else { return }
            guard let _data = data else { return }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: _data) {
                    self?.image = image
                }
            }
        }.resume()
    }
}
