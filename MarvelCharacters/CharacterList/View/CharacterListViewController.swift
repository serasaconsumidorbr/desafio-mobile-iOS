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
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 130
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: "CharacterTableViewCell")
        tableView.refreshControl = refreshControl
        return tableView
    }()
    
    var dataSource: CharacterListDataSource
    
    let interactor: CharacterListInteractorProtocol
    
    init(interactor: CharacterListInteractorProtocol, viewModel: CharacterListDataSource = .initialState) {
        self.interactor = interactor
        self.dataSource = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.loadCharacters(shouldPaginate: false)
    }
    
    override func addSubviews() {
        view.addSubview(tableView)
    }
    
    override func setupConstraints() {
        view.addConstraints([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    override func setupSubviews() {
        view.insetsLayoutMarginsFromSafeArea = true
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc private func refresh(_ sender: Any) {
        interactor.loadCharacters(shouldPaginate: false)
    }

}

extension CharacterListViewController {
    func startLoading() {
        
    }
    
    func stopLoading() {
        refreshControl.endRefreshing()
    }
    
    func updateDataSource(_ characterList: CharacterList, shouldPaginate: Bool) {
        self.dataSource.updating(with: characterList, shouldPaginate: shouldPaginate)
        tableView.reloadData()
    }
}

extension CharacterListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch dataSource.items[indexPath.row] {
        case .character:
            return 130
        case .carousell:
            return 430
        default:
            return 100
        }
    }
}

extension CharacterListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataSource.items[indexPath.row] {
        case let .character(character):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell", for: indexPath) as? CharacterTableViewCell else {
                return UITableViewCell()
            }
            cell.fill(with: character)
            
            return cell
        default:
            return UITableViewCell()
        }
    }
}
