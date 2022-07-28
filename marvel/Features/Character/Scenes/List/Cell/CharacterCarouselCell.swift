//
//  HeroesCarouselCell.swift
//  Marvel (iOS)
//
//  Created by Matheus Custódio on 25/07/22.
//

import UIKit

class CharacterCarouselCell: UICollectionViewCell{
    
    static var identifier: String {
        return String(describing: type(of: self))
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public lazy var imageView: ImageView = {
        let view = ImageView()
        view.contentMode =  .scaleAspectFit
        view.clipsToBounds = true
        view.center = contentView.center
        return view
    }()
    
    public lazy var textContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    public lazy var heroNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name: "
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    public lazy var heroName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    public lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description: "
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    public lazy var descriptionText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        label.numberOfLines = 0
        return label
    }()
    
    func configureLayout() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        textContainer.translatesAutoresizingMaskIntoConstraints = false
        heroNameLabel.translatesAutoresizingMaskIntoConstraints = false
        heroName.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        addSubview(textContainer)
        textContainer.addSubview(heroNameLabel)
        textContainer.addSubview(heroName)
        textContainer.addSubview(descriptionLabel)
        textContainer.addSubview(descriptionText)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            
            textContainer.topAnchor.constraint(equalTo: topAnchor),
            textContainer.rightAnchor.constraint(equalTo: rightAnchor),
            textContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            textContainer.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 10),
            
            heroNameLabel.leftAnchor.constraint(equalTo: textContainer.leftAnchor),
            heroNameLabel.topAnchor.constraint(equalTo: textContainer.topAnchor, constant: 20),
            heroNameLabel.rightAnchor.constraint(equalTo: textContainer.rightAnchor),
            
            heroName.leftAnchor.constraint(equalTo: textContainer.leftAnchor),
            heroName.topAnchor.constraint(equalTo: heroNameLabel.bottomAnchor),
            heroName.rightAnchor.constraint(equalTo: textContainer.rightAnchor),
            
            descriptionLabel.leftAnchor.constraint(equalTo: textContainer.leftAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: heroName.bottomAnchor),
            descriptionLabel.rightAnchor.constraint(equalTo: textContainer.rightAnchor),
            
            descriptionText.leftAnchor.constraint(equalTo: textContainer.leftAnchor),
            descriptionText.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            descriptionText.rightAnchor.constraint(equalTo: textContainer.rightAnchor),
            descriptionText.bottomAnchor.constraint(lessThanOrEqualTo: textContainer.bottomAnchor)
        ])
    }
    
    func configLayout(with hero:Character) {
        imageView.image = nil
        imageView.loadFrom(URLAddress: "\(hero.thumbnail.path).\(hero.thumbnail.extension)")
        heroName.text = hero.name
        if hero.description.isEmpty {
            descriptionText.text = "Not Found!"
        } else {
            descriptionText.text = hero.description
        }
    }
    
}
