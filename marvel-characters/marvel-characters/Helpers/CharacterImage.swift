//
//  CharacterImage.swift
//  marvel-characters
//
//  Created by Paulo Atavila on 06/06/21.
//

import UIKit
import Alamofire

class CharacterImage: UIImageView {
    
    private let loader: UIActivityIndicatorView
    private var imageURLString: String
    
    enum APIPortraitAspectRatio: String {
        case portrait_small       //50x75px
        case portrait_medium      //100x150px
        case portrait_xlarge      //150x225px
        case portrait_fantastic   //168x252px
        case portrait_uncanny     //300x450px
        case portrait_incredible  //216x324px
    }
    
    override init(frame: CGRect) {
        loader = UIActivityIndicatorView()
        loader.style = .medium
        loader.hidesWhenStopped = true
        
        imageURLString = String()
        
        super.init(frame: frame)
        contentMode = .scaleAspectFill
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        addSubview(loader)
        loader.anchor(
            centerX: (centerXAnchor, 0),
            centerY: (centerYAnchor, 50)
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func generateDownloadURL(from urlString: String, with pathExtension: String) -> String {
        return urlString + "/" + APIPortraitAspectRatio.portrait_fantastic.rawValue + "." + pathExtension
    }
    
    func setDefaultImage() {
        DispatchQueue.main.async {
            self.image = Icons.defaultCharacter.image
        }
    }
    
    func loadImage(from urlString: String, with pathExtension: String){
        imageURLString = generateDownloadURL(from: urlString, with: pathExtension)
        
        setDefaultImage()
        
        if let cachedImage = ImageCache.shared.getImage(for: imageURLString) {
            DispatchQueue.main.async {
                self.image = cachedImage
            }
            return
        }
        
        loader.startAnimating()
        
        AF.request(imageURLString).responseImage { response in
            self.loader.stopAnimating()
            if case .success(let downloadedImage) = response.result {
                ImageCache.shared.setImage(downloadedImage, for: self.imageURLString)
                DispatchQueue.main.async {
                    self.image = downloadedImage
                }
            }
        }
    }
}
