//
//  ViewCarousel.swift
//  Marvels
//
//  Created by Moacir Ezequiel Lamego on 24/05/2022.
//

import Foundation

import UIKit

class ViewCarousel: UIView {
    
    // MARK: - Properts
    
    lazy private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        
        return imageView
    }()
    
    lazy private var viewLabels: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        
        return view
    }()
    
    lazy private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textColor = .white
        
        return label
    }()
    
    lazy private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    //MARK: Inits
    
    init(frame: CGRect, url: String, title: String, description: String) {
        super.init(frame: frame)

        self.titleLabel.text = title
        self.descriptionLabel.text = description
        self.imageView.loadImageUsingCache(withUrl: url)
        
        setElementsVisual()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: set Elements Visual
    private func setElementsVisual() {
        setImageView()
        setViewLabels()
        setTitleLabel()
        setSubTitleLabel()        
    }
    
    private func setImageView() {
        self.addSubview(imageView)
        
        let kHeight = UIScreen.main.bounds.height * 0.35
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: self.rightAnchor),
            imageView.heightAnchor.constraint(equalToConstant: kHeight)
        ])
    }

    private func setViewLabels() {
        self.addSubview(viewLabels)
        
        NSLayoutConstraint.activate([
            viewLabels.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            viewLabels.leftAnchor.constraint(equalTo: self.leftAnchor),
            viewLabels.rightAnchor.constraint(equalTo: self.rightAnchor),
            viewLabels.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    private func setTitleLabel() {
        viewLabels.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: viewLabels.topAnchor, constant: 20),
            titleLabel.leftAnchor.constraint(equalTo: viewLabels.leftAnchor, constant: 8),
            titleLabel.rightAnchor.constraint(equalTo: viewLabels.rightAnchor, constant: -8),
        ])
    }

    private func setSubTitleLabel() {
        viewLabels.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.bottomAnchor.constraint(equalTo: viewLabels.bottomAnchor, constant: -10),
            descriptionLabel.leftAnchor.constraint(equalTo: viewLabels.leftAnchor, constant: 8),
            descriptionLabel.rightAnchor.constraint(equalTo: viewLabels.rightAnchor, constant: -8),
        ])
        
        let constraint = descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10)
        constraint.priority = .defaultHigh
        constraint.isActive = true
    }
}
