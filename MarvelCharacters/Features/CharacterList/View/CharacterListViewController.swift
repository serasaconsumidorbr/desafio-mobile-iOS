//
//  CharacterListViewController.swift
//  MarvelCharacters
//
//  Created by Gabriel Beltrame Silva on 03/04/23.
//

import Foundation
import UIKit

class CharacterListViewController: BaseViewCodeController, CharacterListViewControllerProtocol {
    
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        return refresh
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        tableView.allowsSelection = false
        tableView.register(CarousellTableViewCell.self, forCellReuseIdentifier: "CarousellTableViewCell")
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: "CharacterTableViewCell")
        tableView.register(LoadingTableViewCell.self, forCellReuseIdentifier: "LoadingTableViewCell")
        tableView.refreshControl = refreshControl
        return tableView
    }()
    
    let interactor: CharacterListInteractorProtocol
    
    var dataSource: CharacterListDataSource

    let router: CharacterListRouterProtocol
    
    init(
        interactor: CharacterListInteractorProtocol,
        dataSource: CharacterListDataSource,
        router: CharacterListRouterProtocol
    ) {
        self.interactor = interactor
        self.dataSource = dataSource
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addSubviews() {
        view.addSubview(tableView)
    }
    
    override func setupConstraints() {
        view.addConstraints([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    override func setupSubviews() {
        view.insetsLayoutMarginsFromSafeArea = true
        view.backgroundColor = UIColor.white
        title = "Marvel Characters"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Opções",
            style: .plain,
            target: self,
            action: #selector(showOptions)
        )
    }
    
    @objc public func refresh(_ sender: Any) {
        interactor.loadCharacters(shouldPaginate: false)
    }
    
    @objc public func showOptions(_ sender: Any) {
        router.showOptions()
    }
}

extension CharacterListViewController {
    func startLoading() {
        refreshControl.beginRefreshing()
    }
    
    func stopLoading() {
        refreshControl.endRefreshing()
    }
    
    func updateDataSource(_ characterList: CharacterList, shouldPaginate: Bool) {
        dataSource.updating(with: characterList, shouldPaginate: shouldPaginate)
        let newNumberOfItems = characterList.offset + characterList.count
        
        var indexPaths: [IndexPath] = []
        
        let oldLastIndex = tableView.numberOfRows(inSection: 0)
        let newLastIndex = max(newNumberOfItems - 4, 0)
        
        if newLastIndex > oldLastIndex {
            for i in (oldLastIndex-1)...newLastIndex {
                indexPaths.append(IndexPath(row: i, section: 0))
            }
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [IndexPath(row: oldLastIndex-1, section: 0)], with: .left)
            tableView.insertRows(at: indexPaths, with: .right)
            tableView.endUpdates()
        } else {
            tableView.reloadData()
        }
    }
}
