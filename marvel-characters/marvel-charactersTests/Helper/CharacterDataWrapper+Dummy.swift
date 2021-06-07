//
//  CharacterDataWrapper+Dummy.swift
//  marvel-charactersTests
//
//  Created by Paulo Atavila on 06/06/21.
//

@testable import marvel_characters

extension CharacterDataWrapper {
    static func dummy() -> CharacterDataWrapper {
        return CharacterDataWrapper(
            code: 200,
            status: "OK",
            copyright: nil,
            attributionText: nil,
            etag: nil,
            data: CharacterDataContainer(
                offset: 0,
                limit: 20,
                total: 20,
                count: 10,
                results: [
                    Character.dummy(type: .collection),
                    Character.dummy(type: .collection),
                    Character.dummy(type: .collection),
                    Character.dummy(type: .collection),
                    Character.dummy(type: .collection),
                    Character.dummy(type: .regular),
                    Character.dummy(type: .regular),
                    Character.dummy(type: .regular),
                ]
            )
        )
    }
}
