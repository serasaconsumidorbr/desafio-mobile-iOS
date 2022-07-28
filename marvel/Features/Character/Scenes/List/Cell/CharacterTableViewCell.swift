//
//  HeroesTableViewCell.swift
//  Marvel (iOS)
//
//  Created by Matheus Custódio on 26/07/22.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    static var identifier: String {
        return String(describing: type(of: self))
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public lazy var heroImageView: ImageView = {
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
    
    public lazy var heroName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.textAlignment = .left
        return label
    }()
    
    public lazy var descriptionText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    
    func configureLayout() {
        heroImageView.translatesAutoresizingMaskIntoConstraints = false
        textContainer.translatesAutoresizingMaskIntoConstraints = false
        heroName.translatesAutoresizingMaskIntoConstraints = false
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        addSubview(heroImageView)
        addSubview(textContainer)
        textContainer.addSubview(heroName)
        textContainer.addSubview(descriptionText)
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 100),
            
            heroImageView.topAnchor.constraint(equalTo: topAnchor),
            heroImageView.widthAnchor.constraint(equalToConstant: 100),
            heroImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            heroImageView.leftAnchor.constraint(equalTo: leftAnchor),
            
            textContainer.topAnchor.constraint(equalTo: topAnchor),
            textContainer.rightAnchor.constraint(equalTo: rightAnchor),
            textContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            textContainer.leftAnchor.constraint(equalTo: heroImageView.rightAnchor, constant: 10),
            
            heroName.leftAnchor.constraint(equalTo: textContainer.leftAnchor),
            heroName.topAnchor.constraint(equalTo: textContainer.topAnchor),
            heroName.rightAnchor.constraint(equalTo: textContainer.rightAnchor),
            
            descriptionText.leftAnchor.constraint(equalTo: textContainer.leftAnchor),
            descriptionText.topAnchor.constraint(equalTo: heroName.bottomAnchor),
            descriptionText.rightAnchor.constraint(equalTo: textContainer.rightAnchor),
            descriptionText.bottomAnchor.constraint(lessThanOrEqualTo: textContainer.bottomAnchor)
        ])
        
    }
    
    func configLayout(with hero:Character?) {
        guard let hero = hero else {
            return
        }
        heroImageView.image = nil
        heroImageView.loadFrom(URLAddress: "\(hero.thumbnail.path).\(hero.thumbnail.extension)")
        let name = NSMutableAttributedString(string: "Name: \(hero.name)")
        name.addAttribute(.font, value: UIFont.systemFont(ofSize: 12, weight: .bold), range: NSMakeRange(0, 5))
        heroName.attributedText = name
        var description: NSMutableAttributedString
        if hero.description.isEmpty {
            description = NSMutableAttributedString(string: "Description: Not Found!")
        } else {
            description = NSMutableAttributedString(string: "Description: \(hero.description)")
        }
        description.addAttribute(.font, value: UIFont.systemFont(ofSize: 12, weight: .bold), range: NSMakeRange(0, 12))
        descriptionText.attributedText = description
    }
}
