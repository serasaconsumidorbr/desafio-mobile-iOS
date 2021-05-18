//
//  MainCharacterListView.swift
//  Marvel
//
//  Created by andre mietti on 17/05/21.
//

import UIKit

class MainCharacterListView: SceneView {

    private enum Metrics {
        enum ImageView {
            static let side: CGFloat = 100.0
        }
    }
    private let imageView = configure(UIImageView()) {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .clear
    }

    private let titleLabel = configure(UILabel()) {
        $0.font = UIFont.boldSystemFont(ofSize: 18)
        $0.numberOfLines = 0
        $0.textAlignment = .left
        $0.textColor = .white
    }

    override func buildViewHierarchy() {
        backgroundColor = .black
        addSubview(imageView)
        addSubview(titleLabel)
    }

    override func setupConstraints() {
        imageView.constraint {[
            $0.topAnchor.constraint(equalTo: self.topAnchor, constant: MAMetrics.mainTopSpace),
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: MAMetrics.mainLeadingSpace),
            $0.heightAnchor.constraint(equalToConstant: 100.0),
            $0.widthAnchor.constraint(equalToConstant: 100.0),
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: MAMetrics.mainBottomSpace)
        ]}

        titleLabel.constraint {[
            $0.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: MAMetrics.mainLeadingSpace),
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: MAMetrics.mainTrailingSpace),
            $0.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ]}
    }

    func setView(character: CharacterResponseDataModel?) {
        titleLabel.text = character?.name.defaultValue
        guard let path = character?.thumbnail?.path, let thumbnailExtension = character?.thumbnail?.thumbnailExtension else {
            imageView.image = UIImage(named: "defaultLogo")
            return
        }
        imageView.kf.setImage(with: URL(string: path + "." + thumbnailExtension))
    }

}
