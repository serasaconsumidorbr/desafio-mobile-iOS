//
//  CharactersListFooterView.swift
//  marvel-characters
//
//  Created by Paulo Atavila on 06/06/21.
//

import Foundation
import UIKit

public protocol CharactersListFooterViewDelegate: AnyObject {
    func loadMoreItems()
}

class CharactersListFooterView: UIView {
    weak var delegate: CharactersListFooterViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.isAccessibilityElement = true
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
    
    func setupAccessibilityItem() {
        let more = UIAccessibilityCustomAction(
          name: "Touch twice to load more characters.",
          target: self,
          selector: #selector(loadMoreItemsAction))
        
        self.accessibilityCustomActions = [more]
    }
    
    @objc func loadMoreItemsAction() -> Bool {
        delegate?.loadMoreItems()
        return true
    }
}
