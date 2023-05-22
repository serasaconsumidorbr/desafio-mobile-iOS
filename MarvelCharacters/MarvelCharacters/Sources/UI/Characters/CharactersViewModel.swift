//
//  CharactersViewModel.swift
//  MarvelCharacters
//
//  Created by iris on 21/05/23.
//

import RxSwift

class CharactersViewModel: CharactersViewModelProtocol {
    
    // MARK: - PRIVATE PROPERTIES
    
    private let charactersUseCase: CharactersUseCaseType
    internal var characters: [CharacterModel]?
    private let disposeBag = DisposeBag()
    
    // MARK: - PUBLIC PROPERTIES
    public var viewState: BehaviorSubject<CharactersViewState> = .init(value: .loading(asPagination: false))
    public var isPaginating: Bool = false
    
    // MARK: - INITIALIZERS
    
    init(charactersUseCase: CharactersUseCaseType) {
        self.charactersUseCase = charactersUseCase
    }
    
    // MARK: - PUBLIC METHODS
    
    func getCharacters() -> [CharacterModel]? {
        return characters
    }
    
    func getCharacter(at index: Int) -> CharacterModel? {
        guard let character = characters?[index] else { return nil }
        return character
    }
    
    func retrieveCharacters(asPagination: Bool) {
        isPaginating = asPagination
        let offset = !asPagination ? 0 : (characters?.count ?? 0 + 1)
        viewState.onNext(.loading(asPagination: asPagination))
        charactersUseCase.execute(with: .init(offset: offset, limit: 15))
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] result in
                    self?.isPaginating = false
                    self?.handleRetrieveCharacters(result, asPagination: asPagination)
                },
                onError: { [weak self] error in
                    self?.handleError(error)
                }
            )
            .disposed(by: disposeBag)
    }
    
    // MARK: - HANDLERS
    
    private func handleRetrieveCharacters(_ response: Result<[CharacterModel]?, Error>, asPagination: Bool) {
        switch response {
        case .success(let characters):
            handleSuccess(characters, asPagination: asPagination)
        case .failure(let error):
            handleError(error)
        }
    }
    
    private func handleSuccess(_ characters: [CharacterModel]?, asPagination: Bool) {
        guard let characters = characters else { return handleEmptyCharacters() }
        if self.characters == nil {
            self.characters = characters
        } else {
            self.characters?.append(contentsOf: characters)
        }
        viewState.onNext(.success(asPagination: asPagination))
    }
    
    private func handleEmptyCharacters() { }
    
    private func handleError(_ error: Error) {
        viewState.onNext(.error(error))
    }
}
