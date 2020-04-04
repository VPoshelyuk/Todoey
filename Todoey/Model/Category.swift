//
//  Category.swift
//  Todoey
//
//  Created by Slava Pashaliuk on 4/4/20.
//  Copyright © 2020 Viachaslau Pashaliuk. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
//    Properties
    @objc dynamic var name: String = ""
//    Relationships
    let items = List<Item>()
}
