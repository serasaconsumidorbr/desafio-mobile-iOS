//
//  CharactersListHeaderCell.swift
//  marvel-characters
//
//  Created by Paulo Atavila on 06/06/21.
//

import UIKit

class CharactersListHeaderCell: UICollectionViewCell {
    static let identifier = "CharactersListHeaderCell"
    
    let characterImageView: CharacterImage
    let backgroundTitleView: UIView
    let titleLabel: UILabel
    
    override init(frame: CGRect) {
        characterImageView = CharacterImage(frame: .zero)
        backgroundTitleView = UIView()
        titleLabel = UILabel()
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        buildViewHierarchy()
        buildViewConstraints()
        render()
        configureAccessibility()
    }
    
    private func buildViewHierarchy() {
        addSubview(characterImageView)
        characterImageView.addSubview(backgroundTitleView)
        characterImageView.addSubview(titleLabel)
    }
    
    private func buildViewConstraints() {
        characterImageView.anchor(
            top: (topAnchor, 8),
            left: (leftAnchor, 8),
            right: (rightAnchor, 8),
            bottom: (bottomAnchor, 8)
        )
        
        backgroundTitleView.anchor(
            top: (titleLabel.topAnchor, 0),
            left: (characterImageView.leftAnchor, 0),
            right: (characterImageView.rightAnchor, 0),
            bottom: (characterImageView.bottomAnchor, 0)
        )
        
        titleLabel.anchor(
            left: (characterImageView.leftAnchor, 8),
            right: (characterImageView.rightAnchor, 8),
            bottom: (characterImageView.bottomAnchor, 0)
        )
    }
    
    private func render() {
        backgroundColor = .black
        
        backgroundTitleView.backgroundColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = .red
        titleLabel.numberOfLines = 3
    }
    
    func setupData(with character: Character) {
        let name = character.name
        titleLabel.text = name
        if let downloadInfos = character.thumbnail?.getDownloadInfos() {
            characterImageView.loadImage(from: downloadInfos.path, with: downloadInfos.pathExtension)
        } else {
            characterImageView.setDefaultImage()
        }
        setupAccessibility(with: name)
    }
    
    func setupAccessibility(with name: String?) {
        accessibilityLabel = "\(name ?? ""). Touch twice to see more details"
    }
    
    private func configureAccessibility() {
        isAccessibilityElement = true
        titleLabel.isAccessibilityElement = false
        characterImageView.isAccessibilityElement = false
        backgroundTitleView.isAccessibilityElement = false
    }
}
