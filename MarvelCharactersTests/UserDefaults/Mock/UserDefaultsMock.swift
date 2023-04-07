//
//  UserDefaultsMock.swift
//  MarvelCharactersTests
//
//  Created by Gabriel Beltrame Silva on 07/04/23.
//

import Foundation

class UserDefaultsMock: UserDefaults {
  
  convenience init() {
    self.init(suiteName: "UserDefaultsMock")!
  }
  
  override init?(suiteName suitename: String?) {
    UserDefaults().removePersistentDomain(forName: suitename!)
    super.init(suiteName: suitename)
  }
}
