//
//  HeroesListViewController.swift
//  Marvel (iOS)
//
//  Created by Matheus Custódio on 25/07/22.
//

import Foundation

import UIKit

protocol HeroesListViewModelProtocol: AnyObject {
    func onViewDidAppear()
    var carouselItens: [AnyObject] { get }
    var tableViewItens: [AnyObject] { get }
}

class HeroesListViewController: UIViewController, HeroesListViewDelegate {
    
    private let viewModel: HeroesListViewModelProtocol
    
    private lazy var heroesListView: HeroesListView = {
        let view = HeroesListView()
        view.delegate = self
        return view
    }()
    
    init(
        with viewModel: HeroesListViewModelProtocol
    ) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = heroesListView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.onViewDidAppear()
    }
    
}

extension HeroesListViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.carouselItens.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeroesCarouselCell.identifier, for: indexPath) as? HeroesCarouselCell {
            let item = viewModel.carouselItens[indexPath.row]
            print(item)
            return cell
        }
        return UICollectionViewCell()
    }

}

extension HeroesListViewController: UICollectionViewDelegate {
}

extension HeroesListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.tableViewItens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: HeroesTableViewCell.identifier, for: indexPath) as? HeroesTableViewCell {
            let item = viewModel.tableViewItens[indexPath.row]
            print(item)
            return cell
        }
        return UITableViewCell()
    }
    
    
}

extension HeroesListViewController : UITableViewDelegate {
    
}
