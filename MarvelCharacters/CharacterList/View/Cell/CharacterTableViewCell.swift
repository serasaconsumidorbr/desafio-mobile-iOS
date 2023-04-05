//
//  CharacterTableViewCell.swift
//  MarvelCharacters
//
//  Created by Gabriel Beltrame Silva on 04/04/23.
//

import AlamofireImage
import Foundation
import UIKit

class CharacterTableViewCell: UITableViewCell {
    
    private lazy var characterImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureViews()
    }
    
    func configureViews() {
        contentView.addSubview(characterImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        
        contentView.addConstraints([
            characterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 14),
            characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            characterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14),
            characterImageView.heightAnchor.constraint(equalToConstant: 90),
            characterImageView.widthAnchor.constraint(equalToConstant: 105),
            nameLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 14),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -14),
            nameLabel.topAnchor.constraint(equalTo: characterImageView.topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: characterImageView.bottomAnchor)
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
