//
//  CharactersListFooterView.swift
//  marvel-characters
//
//  Created by Paulo Atavila on 06/06/21.
//

import Foundation
import UIKit

class CharactersListFooterView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLoader() {
        let loader = UIActivityIndicatorView()
        loader.center = self.center
        loader.color = .white
        self.addSubview(loader)
        loader.startAnimating()
    }
}
