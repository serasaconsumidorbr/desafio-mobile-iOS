//
//  HomeViewModel.swift
//  Marvel Characters
//
//  Created by Leonardo Bandeira on 30/01/23.
//

import Foundation

protocol HomeViewModeling: AnyObject {
    var totalCharacters: Int { get }
    func getCharacters()
    func getMoreCharacters()
}

final class HomeViewModel: HomeViewModeling {
    // MARK: Property(ies).
    private let service: HomeServicing
    weak var viewController: HomeDisplaying?
    
    private var characters = [Character]()
    private var limit: Int = 50
    private var offset: Int = 0
    
    var totalCharacters: Int {
        characters.count
    }
    
    // MARK: - Initialization(s).
    init(service: HomeServicing) {
        self.service = service
    }
    
    // MARK: - Method(s).
    func getCharacters() {
        performLoading(true)
        service.getCharacters(limit: self.limit, offset: self.offset) { [weak self] result in
            self?.performLoading(false)
            switch result {
            case let .success(model):
                self?.characters.append(contentsOf: model ?? [])
                self?.buildSections()
            case .failure:
                self?.viewController?.displayFailure()
            }
        }
    }
    
    func getMoreCharacters() {
        guard limit + offset <= characters.count else { return }
        offset += 50
        getCharacters()
    }
    
    func buildSections() {
        var carouselModel = [Character]()
        var listModel = [Character]()
        
        characters.enumerated().forEach {
            $0.offset < 5 ? carouselModel.append($0.element) : listModel.append($0.element)
        }
        
        viewController?.displayCharacters(with: [
            SectionModel(section: .carousel, characters: carouselModel),
            SectionModel(section: .list, characters: listModel)
        ])
    }
    
    func performLoading(_ bool: Bool) {
        viewController?.displayLoading(bool)
    }
}
