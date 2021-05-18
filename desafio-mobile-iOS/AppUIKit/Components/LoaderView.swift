//
//  LoaderView.swift
//  Marvel
//
//  Created by andre mietti on 16/05/21.
//

import UIKit
import Lottie

class LoaderView: SceneView {

    lazy var animationView = AnimationView()

    override func buildViewHierarchy() {
        addSubview(animationView)
    }

    override func setupConstraints() {
        animationView.constraint{[
            $0.topAnchor.constraint(equalTo: self.topAnchor),
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]}
    }

    func startAnimation() {
        animationView = .init(name: "iron_man")
        animationView.frame = self.bounds
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        animationView.animationSpeed = 1
        addSubview(animationView)
        animationView.play()
    }

    func stopAnimation() {
        animationView.stop()
        animationView.removeFromSuperview()
    }
}
