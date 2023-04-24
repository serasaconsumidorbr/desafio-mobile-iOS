//
//  HomeViewModel.swift
//  DesafioMobileApp
//
//  Created by Bárbara Tiefensee on 31/01/23.
//

import Foundation

protocol HomeViewModelData {
    var data: HomeViewData { get }
    var isLoading: Bool { get }
}

protocol HomeViewModelProtocol: HomeViewModelData {
    func fetchHeros()
}

final class HomeViewModel {
    
    //MARK: - Properties
    var data: HomeViewData = HomeViewData()
    var isLoading: Bool = false
    
    private let provider: MarvelService
    weak var presenter: HomeViewControllerPresenter?
    
    //MARK: - Init
    init(provider: MarvelService) {
        self.provider = provider
    }
}

//MARK: - Protocol
extension HomeViewModel: HomeViewModelProtocol {
    func fetchHeros() {
        isLoading = true
        provider.fetchChracter { [weak self] result in
            switch result {
            case .success(let success):
                self?.isLoading = false
                guard let heros = success.data?.results else { return }
                self?.data.carrousselInformation = Array(heros[0...4])
                self?.data.heroListInformation = Array(heros[5..<heros.count])
                self?.presenter?.didUpdateView()
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
