//
//  ImageLoader.swift
//  Marvel
//
//  Created by João Pedro on 22/01/21.
//

import UIKit

final class ImageLoader: UIImageView {
    var imageCache = NSCache<AnyObject, AnyObject>()

    lazy var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView() <-< {
        $0.style = .medium
    }

    override init(image: UIImage?, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        setupUI()
    }

    override init(image: UIImage?) {
        super.init(image: image)
        setupUI()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    func setupUI() {
        addSubview(activityIndicator)
        activityIndicator.anchorFillSuperView()
        activityIndicator.startAnimating()
    }

    func loadImage(urlString: String) {
        self.image = nil
        self.activityIndicator.startAnimating()

        if let cacheImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cacheImage
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                debugPrint("Couldn't download image: ", error)
                return
            }

            guard let data = data else { return }
            let image = UIImage(data: data)
            self.imageCache.setObject(image as AnyObject,
                                      forKey: urlString as AnyObject)

            DispatchQueue.main.async {
                self.image = image
                self.activityIndicator.stopAnimating()
            }
        }.resume()
    }
}
