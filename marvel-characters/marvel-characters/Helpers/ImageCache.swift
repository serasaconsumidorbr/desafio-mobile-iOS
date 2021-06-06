//
//  ImageCache.swift
//  marvel-characters
//
//  Created by Paulo Atavila on 06/06/21.
//

import AlamofireImage

protocol ImageCacheProtocol {
    func setImage(_ image: UIImage, for identifier: String)
    func getImage(for identifier: String) -> UIImage?
}

class ImageCache: ImageCacheProtocol {
    static let shared = ImageCache()
    
    private let imageCache: AutoPurgingImageCache
    init() {
        imageCache = AutoPurgingImageCache()
    }
    
    func setImage(_ image: UIImage, for identifier: String) {
        imageCache.add(image, withIdentifier: identifier)
    }
    
    func getImage(for identifier: String) -> UIImage? {
        return imageCache.image(withIdentifier: identifier)
    }
}
