//
//  UIImageView+loadByUrl.swift
//  SerasaMarvel
//
//  Created by Tito Albino Evangelista da Silva Junior on 27/06/21.
//

import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
