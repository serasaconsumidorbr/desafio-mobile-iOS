//
//  CharacterCell.swift
//  SerasaMarvel
//
//  Created by Tito Albino Evangelista da Silva Junior on 27/06/21.
//

import UIKit

class CharacterCell : UICollectionViewCell {
    
    var characterCellConstraints = [NSLayoutConstraint]()

    var surfaceView : UIView = {
        let element = UIView(frame: .zero)
        element.layer.cornerRadius = 4.0
        element.backgroundColor = UIColor(named: "cellBGColor")
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    var thumbImage : UIImageView = {
        let element = UIImageView(frame: .zero)
        element.backgroundColor = .red
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    var titleLabel : UILabel = {
        let element = UILabel(frame: .zero)
        element.text = "Iron man"
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    var subTitleLabel : UILabel = {
        let element = UILabel(frame: .zero)
        element.text = "Atualizado em 27 de junho de 2021"
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViewUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViewUI() {
        
        addSubview(self.surfaceView)
        self.surfaceView.addSubview(self.thumbImage)
        self.surfaceView.addSubview(self.titleLabel)
        self.surfaceView.addSubview(self.subTitleLabel)
        
        self.characterCellConstraints.append(self.surfaceView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8.0))
        self.characterCellConstraints.append(self.surfaceView.topAnchor.constraint(equalTo: self.topAnchor))
        self.characterCellConstraints.append(self.surfaceView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8.0))
        self.characterCellConstraints.append(self.surfaceView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8.0))
        
        
        self.characterCellConstraints.append(self.thumbImage.leadingAnchor.constraint(equalTo: self.surfaceView.leadingAnchor, constant: 8.0))
        self.characterCellConstraints.append(self.thumbImage.topAnchor.constraint(equalTo: self.surfaceView.topAnchor, constant: 8.0))
        self.characterCellConstraints.append(self.thumbImage.bottomAnchor.constraint(equalTo: self.surfaceView.bottomAnchor, constant: -8.0))
        self.characterCellConstraints.append(self.thumbImage.widthAnchor.constraint(equalTo: self.surfaceView.widthAnchor, multiplier: 0.30))
        
        self.characterCellConstraints.append(self.titleLabel.leadingAnchor.constraint(equalTo: self.thumbImage.trailingAnchor, constant: 8.0))
        self.characterCellConstraints.append(self.titleLabel.topAnchor.constraint(equalTo: self.thumbImage.topAnchor))
        self.characterCellConstraints.append(self.titleLabel.trailingAnchor.constraint(equalTo: self.surfaceView.trailingAnchor, constant: -8.0))
        
        self.characterCellConstraints.append(self.subTitleLabel.leadingAnchor.constraint(equalTo: self.thumbImage.trailingAnchor, constant: 8.0))
        self.characterCellConstraints.append(self.subTitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor))
        self.characterCellConstraints.append(self.subTitleLabel.trailingAnchor.constraint(equalTo: self.surfaceView.trailingAnchor, constant: -8.0))
        
        NSLayoutConstraint.activate(self.characterCellConstraints)
        
    }
    
    
    var character: Character? {
         didSet {
             if let name = character?.name {
                self.titleLabel.text = name
             }
            if let updatedAt = character?.modified {
                self.subTitleLabel.text = updatedAt
            }
            if let thumbnail = character?.thumbnail,
               let path = thumbnail.path,
               let ext = thumbnail.ext {
                let url = URL(string: path+"/standard_large."+ext)!
                self.thumbImage.load(url: url)
            }
         }
     }
    
}
