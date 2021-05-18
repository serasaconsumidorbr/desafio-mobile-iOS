//
//  MainViewModel.swift
//  Marvel
//
//  Created by andre mietti on 15/05/21.
//

import Foundation

protocol MainViewModelInput: CloseableViewModel {
    func getCharacters()
    func didSelectCharacter()
}

protocol MainViewModelOutput {
    var showLoading: Observable<Bool> { get }
    var showError: Observable<(title: String, message: String)> { get }
    var setMarvelCollectionView: Observable<[CharacterResponseDataModel]> { get }
    var setMarvelTableView: Observable<[CharacterResponseDataModel]> { get }
}

protocol MainViewModelCoordinating: CloseableCoordinating {
    func showDetailScene()
}

protocol MainViewModelProtocol: MainViewModelInput, MainViewModelOutput {}

class MainViewModel: MainViewModelProtocol {

    private let coordinator: MainViewModelCoordinating
    private let useCase: MainRetrieveCharactersUseCaseProtocol
    private var characters: CharactersDataModel?
    private var offset: Int64 = 0
    private var isLoading: Bool = false

    var showLoading: Observable<Bool> = Observable()
    var showError: Observable<(title: String, message: String)> = Observable()
    var setMarvelCollectionView: Observable<[CharacterResponseDataModel]> = Observable()
    var setMarvelTableView: Observable<[CharacterResponseDataModel]> = Observable()

    init(useCase: MainRetrieveCharactersUseCaseProtocol, coordinator: MainViewModelCoordinating) {
        self.coordinator = coordinator
        self.useCase = useCase
    }

    func getCharacters() {
        if !isLoading {
            isLoading = true
            showLoading.onNext(true)
            useCase.execute(offset: offset) { result in
                self.isLoading = false
                self.showLoading.onNext(false)
                switch result {
                case .success(let response):
                    guard let currentPage = response.data?.offset else {
                        self.offset = 0
                        return
                    }
                    if currentPage > 0 {
                        guard let data = response.data else { return }
                        self.preparePaginationContent(data: data)
                        self.offset += 1
                        return
                    }
                    
                    guard let data = response.data else { return }
                    self.offset += 1
                    self.characters = CharactersDataModel(character: data)
                    self.prepareMarvelCollectionViewContent()
                    self.prepareMarvelTableViewContent()

                case .failure(let error):
                    self.showError.onNext((error.title, error.message))
                }
            }
        }

    }

    private func preparePaginationContent(data: CharactersResponse) {
        let dataModel = CharactersDataModel(character: data)
        self.characters?.results?.append(contentsOf: dataModel.results ?? .defaultValue)
        let uniques = self.removeDuplicateElements(dataModel: self.characters?.results ?? .defaultValue)
        self.characters?.results = uniques
        prepareMarvelTableViewContent()
    }

    private func prepareMarvelCollectionViewContent() {
        guard let results = characters?.results, !results.isEmpty else {
            return
        }
        guard let sliceArray = characters?.results?[0..<5] else { return }
        var fiveStarItems = [CharacterResponseDataModel]()
        fiveStarItems.append(contentsOf: sliceArray)
        self.setMarvelCollectionView.onNext(fiveStarItems)
    }

    private func prepareMarvelTableViewContent() {
        guard let result = characters?.results, !result.isEmpty else {
            return
        }
        guard let sliceArray = characters?.results?[5..<result.count] else { return }
        var listItems = [CharacterResponseDataModel]()
        listItems.append(contentsOf: sliceArray)
        self.setMarvelTableView.onNext(listItems)
    }


    func didSelectCharacter() {
        #warning("implement here")
    }

    func closeScene() {
        coordinator.closeScene()
    }

    func confirmLoan() {
        coordinator.showDetailScene()
    }

    func removeDuplicateElements(dataModel: [CharacterResponseDataModel]) -> [CharacterResponseDataModel] {
        var uniqueModels = [CharacterResponseDataModel]()
        for data in dataModel {
            if !uniqueModels.contains(where: {$0.id == data.id }) {
                uniqueModels.append(data)
            }
        }
        return uniqueModels
    }
}
