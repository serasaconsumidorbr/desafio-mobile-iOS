//
//  LaunchViewController.swift
//  DesafioMobileApp
//
//  Created by Bárbara Tiefensee on 18/04/23.
//

import Foundation
import UIKit
import SnapKit

class LaunchViewController: UIViewController {

    //MARK: - Properties
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.marvel_icon
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        view.backgroundColor = .black
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.center = view.center
        imageView.snp.makeConstraints { make in
            make.size.equalTo(150)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
            self.animate()
        })
    }
    
    //MARK: - Methods
    private func animate() {
        UIView.animate(withDuration: 1) {
            let size = self.view.frame.size.width * 2
            let diffX = size - self.view.frame.size.width
            let diffY = self.view.frame.size.height - size
            
            self.imageView.frame = CGRect(x: -(diffX/2),
                                          y: diffY/2,
                                          width: size,
                                          height: size)
            
            self.imageView.alpha = 0
        } completion: { done in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now()+0.2, execute: {
                    let viewController = HomeViewController()
                    let navigationController: UINavigationController = UINavigationController(rootViewController: viewController)
                    navigationController.modalTransitionStyle = .crossDissolve
                    navigationController.modalPresentationStyle = .fullScreen
                    self.present(navigationController, animated: true)
                })
            }
        }
    }
}
