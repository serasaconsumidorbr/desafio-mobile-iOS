//
//  File.swift
//  
//
//  Created by Lucas Paim on 23/05/21.
//

import UIKit


extension CharacterListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        emptyDataAndLoadAgain()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        emptyDataAndLoadAgain()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchDebouncer.renewInterval()
    }
    
}
