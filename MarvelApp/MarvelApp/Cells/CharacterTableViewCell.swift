//
//  CharacterCollectionViewCell.swift
//  MarvelApp
//
//  Created by Rossana Rocha on 21/05/23.
//

import UIKit
import SnapKit

class CharacterTableViewCell: UITableViewCell {
    
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 24
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .black
        label.text = "Character Name"
        return label
    }()
    
    private let separatorView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        self.backgroundColor = .clear
    }

    @available(*, unavailable)
       required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CharacterTableViewCell {
    
    private func setupLayout() {
        setupCharacterImageView()
        setupNameLabel()
        setupSeparatorView()
    }
    
    private func setupCharacterImageView() {
        self.contentView.addSubview(characterImageView)
        
        characterImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
    }
    
    private func setupNameLabel() {
        self.characterImageView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
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
