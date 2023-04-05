//
//  Character+Mock.swift
//  MarvelCharactersTests
//
//  Created by Gabriel Beltrame Silva on 03/04/23.
//

import Foundation
import MarvelCharacters

extension Character {
    static var mockOne = Character(
        id: 1011334,
        name: "3-D Man",
        description: "",
        imageURL: URL(string: "https://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg")
    )
    
    static var mockTwo = Character(
        id: 1017100,
        name: "A-Bomb (HAS)",
        description: "Rick Jones has been Hulk's best bud since day one, but now he's more than a friend...he's a teammate! Transformed by a Gamma energy explosion, A-Bomb's thick, armored skin is just as strong and powerful as it is blue. And when he curls into action, he uses it like a giant bowling ball of destruction! ",
        imageURL: URL(string: "https://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16.jpg")
    )
    
    static var mockThree = Character(
        id: 1009144,
        name: "A.I.M.",
        description: "AIM is a terrorist organization bent on destroying the world.",
        imageURL: URL(string: "https://i.annihil.us/u/prod/marvel/i/mg/6/20/52602f21f29ec.jpg")
    )
    
    static var mockFour = Character(
        id: 1010699,
        name: "Aaron Stack",
        description: "",
        imageURL: URL(string: "https://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg")
    )
}
