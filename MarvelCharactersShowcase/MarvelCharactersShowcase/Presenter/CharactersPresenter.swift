//
//  CharactersPresenter.swift
//  MarvelCharactersShowcase
//
//  Created by Henrique Legnaro on 19/08/22.
//

import UIKit
import CoreData

protocol CharactersPresenterDelegate {
    func fetchCharacters(offset: Int)
}

class CharactersPresenter: CharactersPresenterDelegate {
    
    let repository = CharactersRepository()
    let viewController: CharactersViewControllerDelegate?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var viewModel: [Character] = []
    var storedViewModel: [CharactersData] = []
    
    init(viewController: CharactersViewControllerDelegate?) {
        self.viewController = viewController
    }
    
    //MARK: - Repository Methods
    func fetchCharacters(offset: Int) {
        viewController?.showLoading()
        repository.fetchCharacters(urlString: K.charactersUrl, offset: offset) { response, error in
            
            if let _ = error {
                self.viewController?.showError()
            }
            
            guard let response = response?.data?.results else {
                self.viewController?.showError()
                return
            }
            
            var names: [String] = []
            
            for character in response {
                if !names.contains(character.name) {
                    self.viewModel.append(character)
                    names.append(character.name)
                }
            }
            
            if self.storedViewModel.isEmpty {
                self.saveItems(response: response)
            }
            
            self.viewController?.showCharacters(viewModel: self.viewModel)
        }
        
    }
    
    //MARK: - Core Data Methods
    func loadItems() {
        let request: NSFetchRequest<CharactersData> = CharactersData.fetchRequest()
        do {
            self.storedViewModel = try self.context.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
        
        if !storedViewModel.isEmpty {
            for character in self.storedViewModel {
                guard let name = character.name, let path = character.path, let ext = character.ext, let comics = Int(character.comics ?? "0"), let series = Int(character.series ?? "0"), let stories = Int(character.stories ?? "0") else { return }
                
                let storedCharacter = Character(
                    name: name,
                    thumbnail: Thumbnail(path: path, extension: ext),
                    comics: Available(available: comics) ,
                    series: Available(available: series),
                    stories: Available(available: stories))
                self.viewModel.append(storedCharacter)
            }
            self.viewController?.showCharacters(viewModel: self.viewModel)
            self.viewModel = []
        }
    }
    
    func saveItems(response: [Character]) {
        if self.viewModel.count <= 50 {
            for char in response {
                let character = CharactersData(context: self.context)
                character.stories = String(char.stories.available)
                character.series = String(char.series.available)
                character.comics = String(char.comics.available)
                character.name = char.name
                character.path = char.thumbnail.path
                character.ext = char.thumbnail.`extension`
                do {
                    try self.context.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
