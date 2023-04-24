//
//  HomeViewController.swift
//  DesafioMobileApp
//
//  Created by Bárbara Tiefensee on 30/01/23.
//

import UIKit

//MARK: - Protocol
protocol HomeViewControllerPresenter: AnyObject {
    func didUpdateView()
}

class HomeViewController: UIViewController {
    
    //MARK: - Properties
    private lazy var homeView = HomeView(viewModel: viewModel)
    private let viewModel = HomeViewModel(provider: MarvelService())

    override func loadView() {
        super.loadView()
        self.view = homeView
        self.viewModel.fetchHeros()
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.viewModel.presenter = self
    }
}

//MARK: - Methods
extension HomeViewController {
    private func setupNavigationBar() {
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 95, height: 25))
        let imageView = UIImageView(image: .marvelStudios_icon)
        imageView.frame = titleView.bounds
        titleView.addSubview(imageView)
        navigationItem.titleView = titleView

        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = UIColor.black_151514.withAlphaComponent(0.5)
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        
    }
}

//MARK: - Protocol
extension HomeViewController: HomeViewControllerPresenter {
    func didUpdateView() {
        homeView.uptadeView()
    }
}
