//
//  ViewCodeController.swift
//  MarvelCharacters
//
//  Created by Gabriel Beltrame Silva on 03/04/23.
//

import Foundation
import UIKit

public protocol ViewCodeController {
    func addSubviews()
    func setupConstraints()
    func setupSubviews()
}

class BaseViewCodeController: UIViewController, ViewCodeController {
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        setupSubviews()
    }
    
    func addSubviews() {
        fatalError("Should be overridden in subclass")
    }
    
    func setupConstraints() {
        fatalError("Should be overridden in subclass")
    }
    
    func setupSubviews() {
        fatalError("Should be overridden in subclass")
    }
}
