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
    @objc dynamic var color: String = UIColor.randomFlat().hexValue()
//    Relationships
    let items = List<Item>()
}
