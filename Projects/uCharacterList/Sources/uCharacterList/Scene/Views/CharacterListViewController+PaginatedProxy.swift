//
//  File.swift
//  
//
//  Created by Lucas Paim on 23/05/21.
//

import UIKit
import InfiniteScrolling


extension CharacterListViewController: UITableViewDataSource, UITableViewDelegate, InfiniteTableLoadable {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func pullToRefresh() {
        elements = []
        startLoading()
        interactor?.fetchCharacterPage(request: .init(offset: 0, search: searchController.searchBar.text))
        tableView.reloadData()
    }
    
    
}
