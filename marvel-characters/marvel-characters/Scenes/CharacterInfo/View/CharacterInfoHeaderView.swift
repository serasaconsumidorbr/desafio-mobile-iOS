//
//  CharacterInfoHeaderView.swift
//  marvel-characters
//
//  Created by Paulo Atavila on 05/06/21.
//

import UIKit

class CharacterInfoHeaderView: UIView {
    var viewModel: CharacterInfoHeaderViewModelProtocol? {
        didSet {
            update()
        }
    }
    
    let characterImageView: CharacterImage
    let backgroundImageView: UIImageView
    let titleLabel: UILabel
    
    override init(frame: CGRect) {
        characterImageView = CharacterImage(frame: .zero)
        backgroundImageView = UIImageView()
        titleLabel = UILabel()
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func update() {
        guard let viewModel = viewModel else {
            return
        }
        let name = viewModel.getCharacterName()
        titleLabel.text = name
        let downloadInfos = viewModel.getCharacterImageInfos()
        characterImageView.loadImage(from: downloadInfos.path, with: downloadInfos.pathExtension)
        backgroundImageView.image = viewModel.getBackgroundImage()
        titleLabel.accessibilityLabel = "\(name ?? ""). Title."
    }
    
    private func setupView() {
        buildViewHierarchy()
        buildViewConstraints()
        render()
    }
    
    private func buildViewHierarchy() {
        addSubview(backgroundImageView)
        addSubview(characterImageView)
        addSubview(titleLabel)
    }
    
    private func buildViewConstraints() {
        backgroundImageView.anchor(
            top: (topAnchor, 0),
            left: (leftAnchor, 0),
            right: (rightAnchor, 0),
            height: 180
        )
        
        characterImageView.anchor(
            left: (leftAnchor, 16),
            bottom: (bottomAnchor, 16),
            width: 168,
            height: 250
        )
        
        titleLabel.anchor(
            left: (characterImageView.rightAnchor, 16),
            right: (rightAnchor, 16),
            bottom: (characterImageView.bottomAnchor, 0)
        )
    }
    
    private func render() {
        backgroundColor = .black
        
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.alpha = 0.4
        backgroundImageView.layer.masksToBounds = true
        
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        titleLabel.textColor = .red
        titleLabel.numberOfLines = 0
    }
}
