//
//  UIImageView+Extension.swift
//  DesafioMobileApp
//
//  Created by Bárbara Tiefensee on 18/04/23.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func loadURL(url: String?, format: String?) {
        guard let urlString = url,
              let format = format else { return }
        let formattedURL = "\(urlString).\(format)"
        guard let urlImage = URL(string: formattedURL) else { return }
        self.kf.setImage(with: urlImage)
    }
}
