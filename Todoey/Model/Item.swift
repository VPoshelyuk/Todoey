//
//  Item.swift
//  Todoey
//
//  Created by Slava Pashaliuk on 4/4/20.
//  Copyright © 2020 Viachaslau Pashaliuk. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
//    Properties
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date = Date()
//    Relationships
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
