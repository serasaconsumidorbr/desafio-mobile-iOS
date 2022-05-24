//
//  CharacterCarouselViewCell.swift
//  Marvels
//
//  Created by Moacir Ezequiel Lamego on 23/05/2022.
//

import Foundation

import UIKit

class CharacterCarouselViewCell: UICollectionViewCell {
    // MARK: - Closures
    
    // MARK: - Constants
    static let identifier = "CharacterCarouselViewCell"
    
    // MARK: - Properts
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textColor = .white
        
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        label.textColor = .white
        
        return label
    }()
    
    //MARK: Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
        
        setElementsVisual()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData() {
        
    }
    
    
    private func setElementsVisual() {
        setImageView()
        setTitleLabel()
        setSubTitleLabel()
        
    }
    
    private func setImageView() {
        self.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: self.rightAnchor),
            imageView.heightAnchor.constraint(equalToConstant: self.frame.height/2)
        ])
    }

    private func setTitleLabel() {
        self.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8),
        ])
    }

    private func setSubTitleLabel() {
        self.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            descriptionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            descriptionLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8),
        ])
    }
}
