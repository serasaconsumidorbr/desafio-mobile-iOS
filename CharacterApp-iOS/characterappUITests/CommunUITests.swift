//
//  CommunUITests.swift
//  characterappUITests
//
//  Created by Denys Galante on 01/06/2021.
//  Copyright © 2021 Denys Galante. All rights reserved.
//

import Foundation

import XCTest
import Quick
import Nimble
import UITestHelper

class CommunUITests: QuickSpec {
    
    static func app(_ app: XCUIApplication, waitForCollectionViewWith timeout: TimeInterval) {
        app.collectionViews["catalog_collection_view"].waitUntilExists(timeout)
        app.cells["catalog_item_cell"].waitUntilExists(timeout)
    }
    
}
