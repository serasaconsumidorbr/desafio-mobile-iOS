//
//  HeroesListViewModel.swift
//  Marvel (iOS)
//
//  Created by Matheus Custódio on 25/07/22.
//

import Foundation

protocol HeroesListViewPresenterProtocol {
    func reloadData()
    func reloadTableView(indexPaths: [IndexPath])
}

class HeroesListViewModel: HeroesListViewModelProtocol {
    
    var currentOffSet: Int = 0
    
    var totalOfItens: Int = 0
    
    var isLoading: Bool = false
    
    
    var carouselItens: [Hero] = []
    var tableViewItens: [Hero] = []
    
    var heroesApi = GetHeroesList()
    
    var presenter: HeroesListViewPresenterProtocol?
    
    func onViewDidAppear() {
        getHeroes()
    }
    
    func getHeroes() {
        if isLoading {
            return
        }
        isLoading = true
        heroesApi.getHeroesList(offset: currentOffSet) { [self] result in
            switch result{
            case .success(let list):
                totalOfItens = list.total
                currentOffSet = list.offset + list.results.count
                if self.carouselItens.count == 0 {
                    self.carouselItens = Array(list.results[0..<5])
                    self.tableViewItens = Array(list.results[5..<list.results.count])
                    presenter?.reloadData()
                } else {
                    let startIndex = self.tableViewItens.count
                    self.tableViewItens.append(contentsOf: list.results)
                    let indexPaths = (startIndex..<self.tableViewItens.count).map { IndexPath(row: $0, section: 0) }
                    presenter?.reloadTableView(indexPaths: indexPaths)
                }
                isLoading = false
            case .failure(let error):
                print("Error loading characters: \(error)")
            }
        }
    }
    
    
}
