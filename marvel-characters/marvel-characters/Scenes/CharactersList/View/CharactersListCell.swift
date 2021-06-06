//
//  CharactersListCell.swift
//  marvel-characters
//
//  Created by Paulo Atavila on 05/06/21.
//

import UIKit

class CharactersListCell: UITableViewCell {
    static let identifier = "CharactersListCellView"
    
    let cardView: UIView
    let lineView: UIView
    let titleLabel: UILabel
    let iconsStackView: UIStackView
    var comicIconImageView: UIImageView
    var storiesIconImageView: UIImageView
    var seriesIconImageView: UIImageView
    var eventIconImageView: UIImageView
    var urlIconImageView: UIImageView
    var arrowIconImageView: UIImageView
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        cardView = UIView()
        lineView = UIView()
        titleLabel = UILabel()
        iconsStackView = UIStackView()
        comicIconImageView = UIImageView()
        storiesIconImageView = UIImageView()
        seriesIconImageView = UIImageView()
        eventIconImageView = UIImageView()
        urlIconImageView = UIImageView()
        arrowIconImageView = UIImageView()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.isUserInteractionEnabled = false
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
        cardView.addSubview(lineView)
        cardView.addSubview(titleLabel)
        cardView.addSubview(iconsStackView)
        cardView.addSubview(arrowIconImageView)
        iconsStackView.addArrangedSubview(comicIconImageView)
        iconsStackView.addArrangedSubview(seriesIconImageView)
        iconsStackView.addArrangedSubview(storiesIconImageView)
        iconsStackView.addArrangedSubview(eventIconImageView)
        iconsStackView.addArrangedSubview(urlIconImageView)
    }
    
    private func buildViewConstraints() {
        cardView.anchor(
            top: (topAnchor, 8),
            left: (leftAnchor, 8),
            right: (rightAnchor, 8),
            bottom: (bottomAnchor, 8)
        )
        
        lineView.anchor(
            top: (cardView.topAnchor, 0),
            left: (cardView.leftAnchor, 0),
            bottom: (cardView.bottomAnchor, 0),
            width: 8
        )
        
        titleLabel.anchor(
            top: (cardView.topAnchor, 8),
            left: (lineView.rightAnchor, 16),
            right: (arrowIconImageView.leftAnchor, 8)
        )
        
        iconsStackView.anchor(
            top: (titleLabel.bottomAnchor, 8),
            left: (titleLabel.leftAnchor, 0),
            bottom: (cardView.bottomAnchor, 0)
        )
        
        arrowIconImageView.anchor(
            centerY: (centerYAnchor, 0),
            right: (cardView.rightAnchor, 8),
            width: 22,
            height: 22
        )
    }
    
    private func render() {
        backgroundColor = .black
        cardView.backgroundColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        cardView.layer.shadowColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8).cgColor
        cardView.layer.shadowOpacity = 0.4
        cardView.layer.shadowRadius = 4
        cardView.layer.shadowOffset = .zero
        cardView.layer.shouldRasterize = true
        cardView.layer.rasterizationScale = UIScreen.main.scale
        cardView.layer.cornerRadius = 10.0
        cardView.clipsToBounds = true
        
        lineView.backgroundColor = .red
        
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        titleLabel.textColor = .red
        
        iconsStackView.axis = .horizontal
        iconsStackView.alignment = .leading
        iconsStackView.distribution = .fill
        iconsStackView.spacing = 16
        
        setupIconImageView(with: UIImage(imageLiteralResourceName: "icon_comic_book"), for: comicIconImageView)
        setupIconImageView(with: UIImage(imageLiteralResourceName: "icon_story"), for: storiesIconImageView)
        setupIconImageView(with: UIImage(imageLiteralResourceName: "icon_event"), for: eventIconImageView)
        setupIconImageView(with: UIImage(imageLiteralResourceName: "icon_book"), for: seriesIconImageView)
        setupIconImageView(with: UIImage(imageLiteralResourceName: "icon_url"), for: urlIconImageView)
        
        arrowIconImageView.tintColor = .gray
        arrowIconImageView.contentMode = .scaleAspectFit
        arrowIconImageView.image = UIImage(imageLiteralResourceName: "icon_arrow")
    }
    
    private func setupIconImageView(with image: UIImage, size: CGFloat = 20, for imageView: UIImageView) {
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        imageView.anchor(
            width: size,
            height: size
        )
        imageView.isHidden = true
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        comicIconImageView.isHidden = true
        seriesIconImageView.isHidden = true
        storiesIconImageView.isHidden = true
        eventIconImageView.isHidden = true
        urlIconImageView.isHidden = true
    }
    
    func setupData(with character: Character) {
        if let name = character.name {
            titleLabel.text = name
        }
        comicIconImageView.isHidden = !(character.comics?.returned ?? 0 > 0)
        seriesIconImageView.isHidden = !(character.series?.returned ?? 0 > 0)
        storiesIconImageView.isHidden = !(character.stories?.returned ?? 0 > 0)
        eventIconImageView.isHidden = !(character.events?.returned ?? 0 > 0)
        urlIconImageView.isHidden = !(character.urls?.count ?? 0 > 0)
    }
}
