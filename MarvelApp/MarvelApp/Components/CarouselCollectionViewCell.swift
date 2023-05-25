//
//  CarouselCollectionViewCell.swift
//  MarvelApp
//
//  Created by Rossana Rocha on 20/05/23.
//

import UIKit
import SnapKit

class CarouselCollectionViewCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.red.cgColor
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 1
        label.textColor = .black
        label.text = "Character Name"
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 3
        label.textColor = .black
        label.text = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam ornare, leo et fringilla vehicula, odio enim malesuada lectus, non posuere libero tellus ut lorem. Aliquam vel nisi elit. Nulla ornare tortor eu faucibus dictum. Phasellus mollis erat vel lacus accumsan eleifend. Praesent ornare felis at leo ornare, id efficitur dolor vehicula.
        """
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CarouselCollectionViewCell {
    
    public func setupWith(character: HomeCharacterModel) {
        self.imageView.image = character.image
        self.titleLabel.text = character.name
        self.descriptionLabel.text = character.description
    }
    
    private func setupLayout() {
        setupImageView()
        setupDescription()
    }
    
    private func setupImageView() {
        self.contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
    }
    
    private func setupDescription() {
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(descriptionLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.leading.equalTo(imageView).offset(16)
            make.trailing.equalTo(imageView).offset(-16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.leading.equalTo(imageView).offset(16)
            make.trailing.equalTo(imageView).offset(-16)
        }
    }
}

