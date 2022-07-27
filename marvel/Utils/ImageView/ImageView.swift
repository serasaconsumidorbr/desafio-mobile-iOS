//
//  ImageView.swift
//  Marvel (iOS)
//
//  Created by Matheus Custódio on 27/07/22.
//

import UIKit

class ImageView: UIImageView {
    
    let activityIndicator: UIActivityIndicatorView
    
    override init(frame: CGRect = .zero) {
        activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityIndicator.hidesWhenStopped = true
        super.init(frame: frame)
        addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadFrom(URLAddress: String) {
        image = nil
        activityIndicator.startAnimating()
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            do {
                let imageData = try Data(contentsOf: url)
                if let loadedImage = UIImage(data: imageData) {
                    DispatchQueue.main.async { [weak self] in
                        self?.activityIndicator.stopAnimating()
                        self?.image = loadedImage
                    }
                }
                
            } catch let error{
                self?.activityIndicator.stopAnimating()
                print(error)
            }
            
        }
    }
}
