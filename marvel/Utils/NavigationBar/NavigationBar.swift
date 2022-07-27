//
//  NavigationBar.swift
//  Marvel (iOS)
//
//  Created by Matheus Custódio on 26/07/22.
//

import UIKit

class NavigationBar: UINavigationBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        barTintColor = .white
        backgroundColor = .white
        isTranslucent = false
        tintColor = .red
        titleTextAttributes = [.foregroundColor: UIColor.black,
                                             .font: UIFont.systemFont(ofSize: 12, weight: .bold)]
        
    }
    
}
