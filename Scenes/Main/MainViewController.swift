//
//  MainViewController.swift
//  Marvel
//
//  Created by andre mietti on 15/05/21.
//

import UIKit
import Lottie

class MainViewController: UIViewController {

    private let rootView = MainView()
    private let viewModel: MainViewModelProtocol
    private let loaderView = LoaderView()
    private var isFromRefreshControl: Bool = false

    init(viewModel: MainViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .black
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        self.addSceneViewToSafeArea(rootView)
        self.automaticallyAdjustsScrollViewInsets = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        rootView.delegate = self
        view.backgroundColor = .white
        self.title = "Marvels Characters"
        setupBinds()
        getCharacters()
    }

    private func getCharacters() {
        viewModel.getCharacters()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .red
        navigationController?.navigationBar.backgroundColor = .black
    }

    private func setupBinds() {
        viewModel.showLoading.observe(on: self) { [weak self] isLoading in
            self?.showLoader(didShow: isLoading)
        }
        viewModel.setMarvelCollectionView.observe(on: self) { [weak self] result in
            self?.rootView.loadMarvelCharacters(characters: result)
        }
        viewModel.setMarvelTableView.observe(on: self) { [weak self] result in
            self?.rootView.loadCharactersInTableView(characters: result)
        }
        viewModel.showError.observe(on: self) {  [weak self] title, message in

        }
    }

    private func showLoader(didShow: Bool) {
        if didShow && !isFromRefreshControl {
            loaderView.contentMode = .scaleAspectFill
            loaderView.bounds = self.view.bounds
            addSceneViewToSafeArea(loaderView)
            loaderView.startAnimation()
            return
        }
        rootView.endRefresh()
        loaderView.stopAnimation()
        loaderView.removeFromSuperview()
    }

}

extension MainViewController: MainViewDelegate {
    func didRefresh() {
        isFromRefreshControl = true
        getCharacters()
    }

    func didMove(to index: Int) {

    }

    func showInstallment() {

    }

    func loadMoreData() {
        isFromRefreshControl = true
        getCharacters()
    }
}

extension MainViewController: MainViewModelCoordinating {
    func showDetailScene() {

    }

    func closeScene() {

    }


}
