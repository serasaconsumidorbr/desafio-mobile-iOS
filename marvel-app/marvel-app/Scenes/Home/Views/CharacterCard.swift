//
//  CharacterCard.swift
//  Marvel Characters
//
//  Created by Leonardo Bandeira on 30/01/23.
//

import SkeletonView
import UIKit

fileprivate extension CharacterCard.Layout {
    enum Spacing {
        static let inset: CGFloat = 16
    }
}

final class CharacterCard: UICollectionViewCell {
    // MARK: - Propery(ies).
    enum Layout {}
    static let identifier = "\(CharacterCard.self)"
    
    // MARK: - Component(s).
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.isSkeletonable = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.textColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initialization(s).
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method(s).
    func configure(with character: Character) -> Self {
        label.text = character.name
        imageView.sd_setImage(with: character.thumbnail?.url)
        return self
    }
    
    // MARK: - Setup(s).
    private func setupLayout() {
        buildViewHierarchy()
        setupConstraints()
        configureView()
    }
}

// MARK: - View Configuration.
private extension CharacterCard {
    private func buildViewHierarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(label)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.Spacing.inset),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Layout.Spacing.inset),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Layout.Spacing.inset)
        ])
    }
    
    private func configureView() {
        isSkeletonable = true
        contentView.backgroundColor = .white
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 8
        
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 8).cgPath
        shadowLayer.fillColor = UIColor.clear.cgColor
        
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowRadius = CGFloat(4)
        shadowLayer.shadowOpacity = Float(0.2)
        shadowLayer.shadowOffset = CGSize(width: 6, height: 12)
        
        self.layer.insertSublayer(shadowLayer, at: 0)
    }
}
