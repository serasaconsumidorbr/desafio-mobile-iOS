import XCTest
@testable import Repository
import RealmSwift

final class DatabaseTests: XCTestCase {
    
    var database: RealmDatabase<DBCharacter>!
    
    override class func setUp() {
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "Database A"
    }
    
    override func setUp() {
        database = RealmDatabase<DBCharacter>()
        database.remove(objects: database.query())
    }
    
    func test_IsSavingData() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        
        //Given
        let character = DBCharacter.stub(id: 1, name: "Homem Aranha")
        
        //When
        database.add(objects: [character])
        
        //Then
        let objects = DBRealm.instance.realm!.objects(DBCharacter.self)
        let item = objects.first!
        
        XCTAssertEqual(item, character)
    }
    
    func test_When_Save_DuplicatedId_IsUpdating() {
        //Given
        let character = DBCharacter.stub(id: 1, name: "Homem Aranha")
        let character2 = DBCharacter.stub(id: 1, name: "Hulk")

        //When
        database.add(objects: [character, character2])
        
        //Then
        let objects = DBRealm.instance.realm!.objects(DBCharacter.self)
        let item = objects.first!
        
        XCTAssertEqual(item, character2)
    }
    
    func test_If_Delete_Is_Working() {
        //Given
        let character = DBCharacter.stub(id: 1, name: "Homem Aranha")
        let character2 = DBCharacter.stub(id: 2, name: "Hulk")

        //When
        database.add(objects: [character, character2])
        database.remove(objects: [character])
        //Then
        let objects = DBRealm.instance.realm!.objects(DBCharacter.self)
        let item = objects.first!
        let anotherItem = objects.last!
        
        XCTAssertEqual(item, character2)
        XCTAssertEqual(item, anotherItem)

    }
    
}



// MARK: - Stub

extension DBCharacter {
    static func stub(
        id: Int, name: String = "name",
        picture: String = "Picture",
        description: String = "Description",
        thumbnail: String = "Thumbnail") -> DBCharacter {
        let character = DBCharacter()
        character.id = id
        character.name = name
        character.picture = picture
        character.characterDescription = description
        character.thumbnail = thumbnail
        return character
    }
}
