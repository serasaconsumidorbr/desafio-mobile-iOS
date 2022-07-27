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
    func getHeroes()
    var carouselItens: [Hero] { get }
    var tableViewItens: [Hero] { get }
    var totalOfItens: Int { get }
}

class HeroesListViewController: UIViewController, HeroesListViewDelegate {
    
    private let viewModel: HeroesListViewModelProtocol
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private lazy var heroesListView: HeroesListView = {
        let view = HeroesListView()
        view.delegate = self
        return view
    }()
    
    init(
        with viewModel: HeroesListViewModelProtocol
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        edgesForExtendedLayout = []
        extendedLayoutIncludesOpaqueBars = false
        navigationController?.setNavigationBarHidden(false, animated: false)
        if let bar = navigationController?.navigationBar {
            bar.barTintColor = .white
            bar.backgroundColor = .white
            bar.isTranslucent = false
            bar.tintColor = .red
            bar.titleTextAttributes = [.foregroundColor: UIColor.black,
                                       .font: UIFont.systemFont(ofSize: 12, weight: .bold)]
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = heroesListView
        let barAppearance = UINavigationBarAppearance()
        barAppearance.backgroundColor = .white
        navigationItem.standardAppearance = barAppearance
        navigationItem.scrollEdgeAppearance = barAppearance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Marvel Heroes!"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.onViewDidAppear()
    }
    
}

extension HeroesListViewController: HeroesListViewPresenterProtocol {
    func reloadTableView(indexPaths: [IndexPath]) {
        heroesListView.tableView.reloadRows(at: indexPaths, with: .automatic)
    }
    
    func reloadData() {
        heroesListView.carouselCollectionView.reloadData()
        heroesListView.tableView.reloadData()
    }
}

extension HeroesListViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.carouselItens.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeroesCarouselCell.identifier, for: indexPath) as? HeroesCarouselCell {
            let item = viewModel.carouselItens[indexPath.row]
            cell.configLayout(with: item)
            return cell
        }
        return UICollectionViewCell()
    }

}

extension HeroesListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.totalOfItens - viewModel.carouselItens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: HeroesTableViewCell.identifier, for: indexPath) as? HeroesTableViewCell {
            if viewModel.tableViewItens.count > indexPath.row {
                let item = viewModel.tableViewItens[indexPath.row]
                cell.configLayout(with: item)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UILabel()
        view.text = "More Heroes: "
        view.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        view.textAlignment = .center
        return view
    }
    
}

extension HeroesListViewController: UITableViewDataSourcePrefetching {
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= viewModel.tableViewItens.count
      }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            viewModel.getHeroes()
          }
    }
}
extension HeroesListViewController : UITableViewDelegate {
    
}
