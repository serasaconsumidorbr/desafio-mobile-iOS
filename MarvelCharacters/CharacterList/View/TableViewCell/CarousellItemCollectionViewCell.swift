//
//  CarousellItemCollectionViewCell.swift
//  MarvelCharacters
//
//  Created by Gabriel Beltrame Silva on 05/04/23.
//

import Foundation
import UIKit

class CarousellItemCollectionViewCell: UICollectionViewCell {
    
    private lazy var characterImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.clipsToBounds = true
        imgView.contentMode = .scaleAspectFill
        imgView.layer.cornerRadius = 4
        return imgView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureViews()
    }
    
    func configureViews() {
        contentView.layer.cornerRadius = 4
        
        contentView.addSubview(characterImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        
        contentView.addConstraints([
            characterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 14),
            characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            characterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -14),
            characterImageView.heightAnchor.constraint(equalTo: characterImageView.widthAnchor, multiplier: 179/211),
            nameLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: characterImageView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: characterImageView.trailingAnchor),
            nameLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -14)
        ])
    }
    
    func fill(with character: Character) {
        if let url = character.imageURL {
            characterImageView.af.setImage(withURL: url)
        } else {
            characterImageView.image = nil
        }
        
        nameLabel.text = character.name
        descriptionLabel.text = character.description
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        characterImageView.image = nil
    }
}
