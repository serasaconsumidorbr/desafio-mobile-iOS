//
//  CharacterCollectionViewCell.swift
//  MarvelApp
//
//  Created by Rossana Rocha on 21/05/23.
//

import UIKit
import SnapKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.red.cgColor
        return imageView
    }()
    
    private let labelBackground = UIView()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 1
        label.textColor = .black
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        label.text = "Character Name"
        return label
    }()
    
    private let separatorView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CharacterCollectionViewCell {
    
    public func setupWith(character: HomeCharacterModel) {
        self.characterImageView.image = character.image
        self.nameLabel.text = character.name
    }
    
    private func setupLayout() {
        setupCharacterImageView()
        setupLabelBackground()
        setupNameLabel()
        setupSeparatorView()
    }
    
    private func setupCharacterImageView() {
        self.contentView.addSubview(characterImageView)
        
        characterImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
    }
    
    private func setupLabelBackground() {
        self.characterImageView.addSubview(labelBackground)
        labelBackground.backgroundColor = .white.withAlphaComponent(0.8)
        
        labelBackground.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.height.equalTo(28)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    private func setupNameLabel() {
        self.labelBackground.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            //make.trailing.equalToSuperview()
        }
    }
    
    private func setupSeparatorView() {
        self.contentView.addSubview(separatorView)
        separatorView.backgroundColor = .clear
        
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(characterImageView.snp.bottom).offset(10)
            make.height.equalTo(10)
            make.bottom.equalToSuperview()
        }
    }
}
