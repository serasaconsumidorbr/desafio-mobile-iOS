//
//  CharacterInfoSectionHeaderView.swift
//  marvel-characters
//
//  Created by Paulo Atavila on 06/06/21.
//

import UIKit

struct CharacterInfoSectionHeader {
    let type: CharacterInfoSectionHederType
    var isOpen: Bool
    var section: Int
    
    init(type: CharacterInfoSectionHederType, section: Int = 0) {
        self.type = type
        isOpen = false
        self.section = section
    }
}

enum CharacterInfoSectionHederType {
    case description, comics, series, stories, events, urls
    
    var title: String {
        switch self {
        case .description:
            return "Description"
        case .comics:
            return "Comics"
        case .series:
            return "Series"
        case .stories:
            return "Stories"
        case .events:
            return "Events"
        case .urls:
            return "Other infos"
        }
    }
    
    var image: UIImage {
        switch self {
        case .description:
            return UIImage(imageLiteralResourceName: "icon_info")
        case .comics:
            return UIImage(imageLiteralResourceName: "icon_comic_book")
        case .series:
            return UIImage(imageLiteralResourceName: "icon_series")
        case .stories:
            return UIImage(imageLiteralResourceName: "icon_story")
        case .events:
            return UIImage(imageLiteralResourceName: "icon_event")
        case .urls:
            return UIImage(imageLiteralResourceName: "icon_url")
        }
    }
}

class CharacterInfoSectionHeaderView: UIControl {
    var section: CharacterInfoSectionHeader? {
        didSet {
            update()
        }
    }
    weak var delegate: CharacterInfoSectionHeaderViewDelegateProtocol?
    
    let iconImageView: UIImageView
    let arrowImageView: UIImageView
    let titleLabel: UILabel
    
    override init(frame: CGRect) {
        iconImageView = UIImageView()
        arrowImageView = UIImageView()
        titleLabel = UILabel()
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func update() {
        guard let section = section else {
            return
        }
        titleLabel.text = section.type.title
        iconImageView.image = section.type.image
        if section.isOpen {
            arrowImageView.transform = arrowImageView.transform.rotated(by: .pi)
        }
    }
    
    private func setupView() {
        buildViewHierarchy()
        buildViewConstraints()
        configure()
        render()
    }
    
    private func buildViewHierarchy() {
        addSubview(iconImageView)
        addSubview(arrowImageView)
        addSubview(titleLabel)
    }
    
    private func buildViewConstraints() {
        iconImageView.anchor(
            centerY: (centerYAnchor, 0),
            left: (leftAnchor, 16),
            width: 24,
            height: 24
        )
        
        titleLabel.anchor(
            top: (topAnchor, 16),
            left: (iconImageView.rightAnchor, 16),
            right: (arrowImageView.leftAnchor, 16),
            bottom: (bottomAnchor, 16)
        )
        
        arrowImageView.anchor(
            centerY: (centerYAnchor, 0),
            right: (rightAnchor, 16),
            width: 16,
            height: 16
        )
    }
    
    @objc func didPressSection() {
        guard let section = section else {
            return
        }
        delegate?.didPressSection(section.section)
    }
    
    private func configure() {
        addTarget(self, action: #selector(didPressSection), for: .touchUpInside)
    }
    
    private func render() {
        backgroundColor = .black
        
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .red
        
        arrowImageView.contentMode = .scaleAspectFit
        arrowImageView.tintColor = .lightGray
        arrowImageView.image = UIImage(imageLiteralResourceName: "icon_arrow")
        arrowImageView.transform = arrowImageView.transform.rotated(by: .pi / 2)
    }
}

protocol CharacterInfoSectionHeaderViewDelegateProtocol: AnyObject {
    func didPressSection(_ section: Int)
}
