//
//  CharacterResponseDataModel.swift
//  Marvel
//
//  Created by andre mietti on 17/05/21.
//

import Foundation

class CharacterResponseDataModel {

    var id: Int?
    var name: String?
    var characterDescription: String?
    var thumbnail: ThumbnailResponse?

    init(chatacter: CharacterResponse) {
        self.id = chatacter.id
        self.name = chatacter.name
        self.characterDescription = chatacter.characterDescription
        self.thumbnail = chatacter.thumbnail
    }

}
