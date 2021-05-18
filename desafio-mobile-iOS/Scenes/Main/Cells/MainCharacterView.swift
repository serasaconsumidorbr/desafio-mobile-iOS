//
//  MainCharacterView.swift
//  Marvel
//
//  Created by andre mietti on 15/05/21.
//

import UIKit
import Kingfisher

class MainCharacterView: SceneView {

    private enum Metrics {
        enum Label {
            static let leading: CGFloat = 20
            static let trailing: CGFloat = -20
            static let bottom: CGFloat = -10
        }
    }

    private let imageView = configure(UIImageView()) {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .clear
    }

    override func buildViewHierarchy() {
        addSubview(imageView)
    }

    override func setupConstraints() {
        imageView.constraint {[
            $0.topAnchor.constraint(equalTo: self.topAnchor),
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]}
    }

    func loadView(character: CharacterResponseDataModel?) {
        guard let path = character?.thumbnail?.path, let thumbnailExtension = character?.thumbnail?.thumbnailExtension else {
            imageView.image = UIImage(named: "defaultLogo")
            return
        }
        imageView.kf.setImage(with: URL(string: path + "." + thumbnailExtension))
    }
}
