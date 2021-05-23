//
//  File.swift
//  
//
//  Created by Lucas Paim on 23/05/21.
//

import UIKit
import AppColors


open class BaseViewController: UIViewController {
    
    var loadingView: LoadingView?
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appBackgroundColor
        setupUI()
    }
    
    open func setupUI() { }
    
    public func startLoading() {
        guard loadingView == nil else {
            loadingView?.play()
            return
        }
        
        let loadingView = LoadingView()
        self.loadingView = loadingView
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        loadingView.play()
    }
    
    public func stopLoading() {
        loadingView?.stop()
        loadingView?.removeFromSuperview()
        loadingView = nil
    }
    
}
