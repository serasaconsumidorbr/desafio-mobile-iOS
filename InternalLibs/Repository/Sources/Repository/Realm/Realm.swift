//
//  File.swift
//  
//
//  Created by Lucas Paim on 22/05/21.
//

import Foundation
import RealmSwift


final class DBRealm {
    
    static var instance = DBRealm()
    
    fileprivate init() {
        initiateRealm()
    }
    
    lazy var realmConfig: Realm.Configuration = {
        Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { _,_ in }
        )
    }()
    
    var realm: Realm? = nil
    
    private func initiateRealm() {
        do {
            self.realm = try Realm(
                configuration: realmConfig
            )
        } catch let error {
            debugPrint("-----------------------")
            debugPrint("An error has ocurred with local cache")
            debugPrint(error)
            debugPrint("-----------------------")
        }
    }
    
}
