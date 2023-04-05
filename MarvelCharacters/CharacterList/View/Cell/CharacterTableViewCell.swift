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
        return imgView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
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
        
        contentView.addConstraints([
            characterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            characterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            characterImageView.heightAnchor.constraint(equalToConstant: 100),
            characterImageView.widthAnchor.constraint(equalToConstant: 100),
            nameLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func fill(with character: Character) {
        if let url = character.imageURL {
            characterImageView.af.setImage(withURL: url)
        } else {
            characterImageView.image = nil
        }
        
        nameLabel.text = character.name
    }
}
