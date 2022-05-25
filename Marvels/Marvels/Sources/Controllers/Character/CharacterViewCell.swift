//
//  CharacterViewCell.swift
//  Marvels
//
//  Created by Moacir Ezequiel Lamego on 24/05/2022.
//

import Foundation
import UIKit

class CharacterViewCell: UITableViewCell {
    
    // MARK: - Constants
    static let identified = "CharacterViewCell"
    
    // MARK: - Properts
    lazy private var thunbView: UIImageView = {
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
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func setData(url: String, title: String, description: String) {
        self.titleLabel.text = title
        self.descriptionLabel.text = description
        self.thunbView.loadImageUsingCache(withUrl: url)
        
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
        self.addSubview(thunbView)
        
        let kHeight = UIScreen.main.bounds.height * 0.3
        
        NSLayoutConstraint.activate([
            thunbView.topAnchor.constraint(equalTo: self.topAnchor),
            thunbView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            thunbView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            thunbView.heightAnchor.constraint(equalToConstant: kHeight)
        ])
    }

    private func setViewLabels() {
        self.addSubview(viewLabels)
        
        NSLayoutConstraint.activate([
            viewLabels.topAnchor.constraint(equalTo: thunbView.bottomAnchor),
            viewLabels.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            viewLabels.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            viewLabels.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    private func setTitleLabel() {
        viewLabels.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: viewLabels.topAnchor, constant: 12),
            titleLabel.leftAnchor.constraint(equalTo: viewLabels.leftAnchor, constant: 0),
            titleLabel.rightAnchor.constraint(equalTo: viewLabels.rightAnchor, constant: 0),
        ])
    }

    private func setSubTitleLabel() {
        viewLabels.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leftAnchor.constraint(equalTo: viewLabels.leftAnchor, constant: 0),
            descriptionLabel.rightAnchor.constraint(equalTo: viewLabels.rightAnchor, constant: 0),
        ])
    }
}
