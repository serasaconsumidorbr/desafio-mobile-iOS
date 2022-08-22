//
//  SpiderManLoadingView.swift
//  MarvelCharactersShowcase
//
//  Created by Henrique Legnaro on 21/08/22.
//

import UIKit
import Lottie

class SpiderManLoadingView {
    
    let spiderMan = AnimationView()
    let loading = AnimationView()
    let backgroundView = UIView()
    
    let vc: UIViewController
    
    init (vc: UIViewController) {
        self.vc = vc
    }
    
    func showLoading() {
        spiderMan.animation = Animation.named("fetchingSpiderman")
        spiderMan.frame = CGRect(x: (vc.view.frame.width/2) - 150, y: (vc.view.frame.height/2) - 150, width: 300.0, height: 300.0)
        spiderMan.contentMode = .scaleToFill
        spiderMan.loopMode = .loop
        spiderMan.play()
        
        loading.animation = Animation.named("loading")
        loading.frame = CGRect(x: (vc.view.frame.width/2) - 200, y: (vc.view.frame.height/2) - 200, width: 400.0, height: 200.0)
        loading.contentMode = .scaleToFill
        loading.loopMode = .loop
        loading.play()
        
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0
        backgroundView.frame = vc.view.bounds
        
        
        UIView.animate(withDuration: 0.25) {
            self.backgroundView.alpha = 0.9
        }
        
        vc.view.addSubview(backgroundView)
        vc.view.addSubview(spiderMan)
        vc.view.addSubview(loading)
    }
    
    func dismissLoading() {
        
        UIView.animate(withDuration: 1.0) {
            self.backgroundView.alpha = 0.0
            self.loading.frame = CGRect(x: (self.vc.view.frame.width/2) - 200, y: (self.vc.view.frame.height), width: 400.0, height: 200.0)
            self.spiderMan.frame = CGRect(x: (self.vc.view.frame.width/2) - 150, y: (self.vc.view.frame.height), width: 300.0, height: 300.0)
        } completion: { done in
            if done {
                self.loading.removeFromSuperview()
                self.spiderMan.removeFromSuperview()
            }
        }
    }
    
}
