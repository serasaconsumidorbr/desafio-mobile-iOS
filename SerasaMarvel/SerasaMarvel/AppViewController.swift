//
//  ViewController.swift
//  SerasaMarvel
//
//  Created by Tito Albino Evangelista da Silva Junior on 25/06/21.
//

import UIKit
import Combine

class AppViewController: UIViewController {
    
    var viewModel: MavenViewModel?
    private var subscriptions: Set<AnyCancellable> = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpView()
        
        viewModel?.$state.sink { [weak self] value in
            
            switch value {
            case .loading:
                print("Carregando")
            case .failed(let error):
                print("Failed \(error.localizedDescription)")
            case .success(let value):
                print(value)
                break
            }
            
        }.store(in: &subscriptions)
        
        viewModel?.getAllCharacters()
        
    }
    
    func setUpView() {
        view.backgroundColor = .white
    }
    
    
}

