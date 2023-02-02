//
//  CharacterListCell.swift
//  Marvel Characters
//
//  Created by Leonardo Bandeira on 31/01/23.
//

import SDWebImage
import SkeletonView
import UIKit

fileprivate extension CharacterListCell.Layout {
    enum Size {
        static let itemHeight: CGFloat = 90
    }
    
    enum Spacing {
        static let horizontalInset: CGFloat = 16
        static let verticalInset: CGFloat = 8
    }
}

final class CharacterListCell: UITableViewCell {
    // MARK: - Propery(ies).
    enum Layout {}
    static let identifier = "\(CharacterListCell.self)"
    
    // MARK: - Component(s).
    private lazy var container: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.isSkeletonable = true
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var characterImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .center
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.isSkeletonable = true
        label.textAlignment = .right
        label.textColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initialization(s).
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method(s).
    func configure(with character: Character) -> Self {
        label.text = character.name
        characterImageView.sd_setImage(with: character.thumbnail?.url)
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
private extension CharacterListCell {
    private func buildViewHierarchy() {
        contentView.addSubview(container)
        container.addSubview(characterImageView)
        characterImageView.addSubview(label)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: Layout.Size.itemHeight),
            
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Layout.Spacing.verticalInset),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.Spacing.horizontalInset),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Layout.Spacing.verticalInset),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Layout.Spacing.horizontalInset),
            
            characterImageView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            characterImageView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            
            label.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: Layout.Spacing.horizontalInset),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -Layout.Spacing.horizontalInset)
        ])
    }
    
    private func configureView() {
        isSkeletonable = true
        contentView.backgroundColor = .white
        
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 8).cgPath
        shadowLayer.fillColor = UIColor.clear.cgColor
        
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowRadius = CGFloat(6)
        shadowLayer.shadowOpacity = Float(0.20)
        shadowLayer.shadowOffset = CGSize(width: 54, height: 54)
        
        contentView.layer.insertSublayer(shadowLayer, at: 0)
    }
}
