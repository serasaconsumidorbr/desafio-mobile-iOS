//
//  ViewController.swift
//  characterapp
//
//  Created by Denys Galante on 01/06/2021.
//  Copyright © 2021 Denys Galante. All rights reserved.
//

import Foundation
import UIKit

class ViewController<ViewType: UIView>: UIViewController, ViewConfiguration {
    
    var customView: ViewType {
        return view as! ViewType
    }
    
    override func loadView() {
        let newView: ViewType = makeView(with: ViewType.self)
        newView.backgroundColor = .white
        view = newView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildViewHierarchy()
        setupConstraints()
        configureViews()
    }
    
    private func makeView<ViewType: UIView>(with type: ViewType.Type) -> ViewType {
        return ViewType()
    }
    
    func buildViewHierarchy() {}
    func setupConstraints() {}
    func configureViews() {}
}


