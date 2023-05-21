//
//  ComicsUseCase.swift
//  ChallengeAID
//
//  Created by Wilton Ramos da Silva on 04/07/22.
//

import RxSwift

protocol CharactersUseCaseType {
    func execute(with requestModel: CharactersRequestModel) -> Observable<Result<[CharacterModel]?, Error>>
}

class CharactersUseCase: CharactersUseCaseType {
    
    // MARK: - ALIASES
    
    typealias UseCaseEventType = Result<[CharacterModel]?, Error>
    typealias ServiceReturningType = Result<CharacterDataWrapper, Error>
    
    // MARK: - PRIVATE PROPERTIES
    
    private let networking: NetworkingOperationType
    
    // MARK: - INITIALIZERS
    
    init(networking: NetworkingOperationType) {
        self.networking = networking
    }
    
    // MARK: - PUBLIC FUNCTIONS
    
    func execute(with requestModel: CharactersRequestModel) -> Observable<UseCaseEventType> {
        return createObservable(with: requestModel)
    }
    
    // MARK: - PRIVATE FUNCTIONS
    
    private func createObservable(with requestModel: CharactersRequestModel) -> Observable<UseCaseEventType> {
        return .create { [weak self] observer in
            guard let self = self else { return Disposables.create() }
            self.makeRequest(with: requestModel, observer)
            return Disposables.create()
        }
    }
    
    private func makeRequest(with requestModel: CharactersRequestModel, _ observer: AnyObserver<UseCaseEventType>) {
        let request = CharacterRequest(cases: .characters(model: requestModel))
        networking.request(request: request) { [weak self] (result: ServiceReturningType) in
            guard let self = self else { return }
            observer.onNext(self.handleResult(result))
        }
    }
    
    private func convertCharacterToModel(_ character: Character) -> CharacterModel? {
        guard character.id != nil else { return nil }
        return CharacterModel(id: String(character.id!),
                              name: character.name,
                              description: character.description,
                              imagePath: character.thumbnail?.path,
                              imageExtension: character.thumbnail?.thumbnailExtension)
    }

    // MARK: - HANDLERS
    
    private func handleResult(_ result: ServiceReturningType) -> UseCaseEventType {
        switch result {
        case .success(let data):
            return handleSuccess(data)
        case .failure(let error):
            return handleError(error)
        }
    }
    
    private func handleSuccess(_ data: CharacterDataWrapper) -> UseCaseEventType {
        let characters = data.data?.results
        let characterObjects: [CharacterModel]? = characters?.compactMap({ character in
            return convertCharacterToModel(character)
        })
        return .success(characterObjects)
    }
    
    private func handleError(_ error: Error) -> UseCaseEventType {
        return .failure(error)
    }
}
