//
//  CharacterSpotlight.swift
//  CharactersMarvel
//
//  Created by Tito Albino Evangelista da Silva Junior on 27/06/21.
//

import UIKit

class CharacterSpotlightCell : UICollectionViewCell {
    
    var cellConstraints = [NSLayoutConstraint]()
    
    var surfaceView : UIView = {
        let element = UIView(frame: .zero)
        element.layer.cornerRadius = 8.0
        element.layer.masksToBounds = true
        element.backgroundColor = UIColor(named: "cellBG")
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    var labelSurfaceView : UIView = {
        let element = UIView(frame: .zero)
        element.backgroundColor = UIColor.black
        element.alpha = 0.7
        element.layer.masksToBounds = true
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    var thumbImage : UIImageView = {
        let element = UIImageView(frame: .zero)
        element.layer.masksToBounds = true
        element.layer.cornerRadius = 4.0
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    var titleLabel : UILabel = {
        let element = UILabel(frame: .zero)
        element.text = "Iron man"
        element.textColor = .white
        element.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.largeTitle)
        element.sizeToFit()
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
        thumbImage.addSubview(self.labelSurfaceView)
        self.labelSurfaceView.addSubview(self.titleLabel)
    
        self.cellConstraints.append(self.surfaceView.leadingAnchor.constraint(equalTo: self.leadingAnchor))
        self.cellConstraints.append(self.surfaceView.topAnchor.constraint(equalTo: self.topAnchor))
        self.cellConstraints.append(self.surfaceView.bottomAnchor.constraint(equalTo: self.bottomAnchor))
        self.cellConstraints.append(self.surfaceView.widthAnchor.constraint(equalTo: self.widthAnchor))
        
        self.cellConstraints.append(self.thumbImage.leadingAnchor.constraint(equalTo: self.surfaceView.leadingAnchor))
        self.cellConstraints.append(self.thumbImage.topAnchor.constraint(equalTo: self.surfaceView.topAnchor))
        self.cellConstraints.append(self.thumbImage.bottomAnchor.constraint(equalTo: self.surfaceView.bottomAnchor))
        self.cellConstraints.append(self.thumbImage.widthAnchor.constraint(equalTo: self.surfaceView.widthAnchor))
        
        self.cellConstraints.append(self.labelSurfaceView.leadingAnchor.constraint(equalTo: self.thumbImage.leadingAnchor))
        self.cellConstraints.append(self.labelSurfaceView.trailingAnchor.constraint(equalTo: self.thumbImage.trailingAnchor))
        self.cellConstraints.append(self.labelSurfaceView.bottomAnchor.constraint(equalTo: self.thumbImage.bottomAnchor))
        
        self.cellConstraints.append(self.titleLabel.leadingAnchor.constraint(equalTo: self.labelSurfaceView.leadingAnchor, constant: 16.0))
        self.cellConstraints.append(self.titleLabel.trailingAnchor.constraint(equalTo: self.labelSurfaceView.trailingAnchor, constant: -16.0))
        self.cellConstraints.append(self.titleLabel.topAnchor.constraint(equalTo: self.labelSurfaceView.topAnchor, constant: 12.0))
        self.cellConstraints.append(self.titleLabel.bottomAnchor.constraint(equalTo: self.labelSurfaceView.bottomAnchor, constant: -12.0))
        
        
        
        
        NSLayoutConstraint.activate(self.cellConstraints)
        
    }
    
    
    var character: Character? {
         didSet {
             if let name = character?.name {
                self.titleLabel.text = name
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
