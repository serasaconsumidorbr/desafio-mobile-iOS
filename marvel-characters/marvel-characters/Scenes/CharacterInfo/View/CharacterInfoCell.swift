//
//  CharacterInfoCell.swift
//  marvel-characters
//
//  Created by Paulo Atavila on 06/06/21.
//

import UIKit

enum CharacterInfoType {
    case text, button
    
    var title: String {
        return "See more"
    }
}

struct CharacterInfo {
    var title: String?
    var type: CharacterInfoType
}

class CharacterInfoCell: UITableViewCell {
    static let identifier = "CharacterInfoCell"
    
    let cardView: UIView
    let titleLabel: UILabel
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        cardView = UIView()
        titleLabel = UILabel()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        buildViewHierarchy()
        buildViewConstraints()
        render()
    }
    
    private func buildViewHierarchy() {
        addSubview(cardView)
        cardView.addSubview(titleLabel)
    }
    
    private func buildViewConstraints() {
        cardView.anchor(
            top: (topAnchor, 8),
            left: (leftAnchor, 8),
            right: (rightAnchor, 8),
            bottom: (bottomAnchor, 8)
        )
        
        titleLabel.anchor(
            top: (cardView.topAnchor, 16),
            left: (cardView.leftAnchor, 16),
            right: (cardView.rightAnchor, 16),
            bottom: (cardView.bottomAnchor, 16)
        )
    }
    
    private func render() {
        backgroundColor = .black
        cardView.backgroundColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        cardView.layer.cornerRadius = 10.0
        
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
    }
    
    func setupData(with info: CharacterInfo) {
        switch info.type {
        case .text:
            titleLabel.text = info.title
            titleLabel.textAlignment = .left
        case .button:
            titleLabel.text = CharacterInfoType.button.title
            titleLabel.textAlignment = .center
        }
    }
}
