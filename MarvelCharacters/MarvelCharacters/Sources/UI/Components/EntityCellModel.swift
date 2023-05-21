//
//  EntityCellModel.swift
//  MarvelCharacters
//
//  Created by iris on 21/05/23.
//

struct EntityCellModel {
    
    // MARK: - PUBLIC PROPERTIES
    
    let title: String?
    let description: String?
    let imagePath: String?
    let imageExtension: String?
    
    // MARK: - INITIALIZER
    
    init(title: String?,
         description: String?,
         imagePath: String?,
         imageExtension: String?) {
        self.title = title
        self.description = description
        self.imagePath = imagePath
        self.imageExtension = imageExtension
    }
    
    func getImageUrl() -> String {
        guard let imagePath = imagePath,
              let imageExtension = imageExtension else {
            return ""
        }
        return "\(imagePath)/portrait_fantastic.\(imageExtension)"
    }
}
