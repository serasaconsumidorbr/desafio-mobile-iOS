//
//  CharacterDataStore.swift
//  Marvels
//
//  Created by Moacir Ezequiel Lamego on 25/05/2022.
//

import Foundation
import UIKit
import CoreData

public class CharacterDataStore {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var items: [CharacterData]?
    
    func getAllItems() {
        do {
            let items = try context.fetch(CharacterData.fetchRequest())
            self.items = items
        }
        catch {
            debugPrint("Erro ao buscar os itens no coredata")
        }
    }
    
    func createItem(withModel model: CharacterModel, completionHandler: @escaping CharacterDataStoreCompletionHandler) {
        guard let data = model.data?.results else { return }
        
        for itemModel in data {
            let ext = itemModel.thumbnail?.thumbnailExtension ?? ""
            let path = itemModel.thumbnail?.path ?? ""
            let thunbnailCarousel = "\(path)/\(ImageVariants.portrait_uncanny.rawValue).\(ext)"
            let thunbnailList = "\(path)/\(ImageVariants.landscape_large.rawValue).\(ext)"
            let uid = Int64(itemModel.id ?? 0)
            
            if !thunbnailCarousel.contains("image_not_available") {
                if let itemExists = self.items?.first(where: {$0.uid == uid}) {
                    itemExists.name = itemModel.name ?? ""
                    itemExists.about = itemModel.resultDescription ?? ""
                    itemExists.thunbnailCarousel = thunbnailCarousel
                    itemExists.thunbnailList = thunbnailList
                } else {
                    let newItem = CharacterData(context: context)
                    newItem.uid = uid
                    newItem.name = itemModel.name ?? ""
                    newItem.about = itemModel.resultDescription ?? ""
                    newItem.thunbnailCarousel = thunbnailCarousel
                    newItem.thunbnailList = thunbnailList
                }
            }
        }
        
        saveContext()
        getAllItems()
        
        completionHandler(self)
    }
    
    
    func deleteItem(item: CharacterData) {
        context.delete(item)
        
        saveContext()
    }
    
    func updateItem(item: CharacterData) {
        saveContext()
    }
    
    private func saveContext() {
        do {
            try context.save()
        }
        catch {
            debugPrint("Erro ao salvar o contexto do coredata")
        }
    }
}
