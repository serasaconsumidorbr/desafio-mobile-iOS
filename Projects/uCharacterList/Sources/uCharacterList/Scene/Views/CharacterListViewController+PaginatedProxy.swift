//
//  File.swift
//  
//
//  Created by Lucas Paim on 23/05/21.
//

import UIKit
import InfiniteScrolling
import AppCoreUI


extension CharacterListViewController: UITableViewDataSource, UITableViewDelegate, InfiniteTableLoadable {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(CharacterCell.self, for: indexPath)
        let character = elements[indexPath.row]
        cell.populateView(character: character)
        return cell
    }
    
    func pullToRefresh() {
        elements = []
        featuredItems = []
        startLoading()
        interactor?.fetchCharacterPage(request: .init(offset: 0, search: searchController.searchBar.text))
        tableView.reloadData()
    }
    
    func emptyCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeue(EmptyCell.self, for: indexPath)
    }
    
    func loadingCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeue(LoadingCell.self, for: indexPath)
    }
    
    func retryCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeue(RetryCell.self, for: indexPath)
    }
    
}
