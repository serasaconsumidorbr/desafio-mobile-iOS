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

struct EntityCellsModel {
    let cell: [EntityCellModel]
    
    init(cell: [EntityCellModel]) {
        self.cell = cell
    }
    
    func getImagesUrl() -> [String] {
        var imagesUrl: [String] = []
        for i in 0...4 {
            imagesUrl.append(getImageUrl(imagePath: cell[i].imagePath ?? "", imageExtension: cell[i].imageExtension ?? ""))
        }
        return imagesUrl
    }
    func getImageUrl(imagePath: String, imageExtension: String) -> String {
        
        let imagePath = imagePath
        let imageExtension = imageExtension
        return "\(imagePath)/portrait_fantastic.\(imageExtension)"
    }
}
