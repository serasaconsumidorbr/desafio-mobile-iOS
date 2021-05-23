//
//  File.swift
//  
//
//  Created by Lucas Paim on 23/05/21.
//

import UIKit
import AppColors
import SnapKit
import Lottie


final class LoadingView: BaseCustomView {
    
    lazy var blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
    lazy var blurEffectView = UIVisualEffectView(effect: blurEffect)

    lazy var loadingView = AnimationView(name: "loading")
    
    override func setupUI() {
        super.setupUI()
        addSubview(blurEffectView)
        blurEffectView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        configureLottieView()
        blurEffectView.contentView.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.height.width.equalTo(snp.width).multipliedBy(0.7)
            make.centerX.centerY.equalToSuperview()
        }
        
        isUserInteractionEnabled = false
    }
    
    func configureLottieView() {
        loadingView.backgroundColor = .clear
        loadingView.contentMode = .scaleAspectFit
        loadingView.loopMode = .loop
        loadingView.animationSpeed = 0.5
    }
    
    func play() {
        loadingView.play()
    }
    
    func stop() {
        loadingView.stop()
    }
    
}
