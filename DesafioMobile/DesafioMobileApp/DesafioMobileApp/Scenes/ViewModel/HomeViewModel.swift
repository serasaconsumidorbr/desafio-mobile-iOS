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
    
    
    var personagens: [CharacterModel] { get set }
    var currentPage : Int { get set }
    var loadingPage : Bool { get set}
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
    
    
    var personagens: [CharacterModel] = [CharacterModel]()
    var currentPage: Int = 0
    var loadingPage: Bool = false
    
    
    //MARK: - Init
    init(provider: MarvelService) {
        self.provider = provider
    }
    
    func setData() {
        self.data.carrousselInformation = Array(self.personagens[0...4])
        self.data.heroListInformation = Array(self.personagens[5..<self.personagens.count])
    }
}

//MARK: - Protocol
extension HomeViewModel: HomeViewModelProtocol {
    func fetchHeros() {
        isLoading = true
        loadingPage = true
        provider.fetchChracter(pages: String(currentPage)) { [weak self] result in
            switch result {
            case .success(let success):
                self?.isLoading = false
                guard let heros = success.data?.results else { return }
                self?.personagens += heros
                self?.setData()
                self?.presenter?.didUpdateView()
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
