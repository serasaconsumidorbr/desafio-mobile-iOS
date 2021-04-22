//
//  DefaultViewController.swift
//  Marvel
//
//  Created by João Pedro on 21/01/21.
//

import UIKit

open class DefaultViewController: UIViewController {

    // MARK: - Var's
    var viewDidApperFirstTimeVar: Bool = true

    // MARK: - Load
    open override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint("********** \(type(of: self)) **********")
        setupUI()
    }

    func setupUI() { }

    // MARK: - Appear
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if viewDidApperFirstTimeVar {
            viewDidApperFirstTime()
            viewDidApperFirstTimeVar = false
        }
    }

    func viewDidApperFirstTime() { }

    // MARK: - Deinit
    deinit {
        debugPrint("********** DEINIT: \(type(of: self)) **********")
    }
}

