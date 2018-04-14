//
//  Data.swift
//  Todoey
//
//  Created by Константин Клинов on 4/14/18.
//  Copyright © 2018 Константин Клинов. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object {
    @objc dynamic var name : String = ""
    @objc dynamic var age : Int = 0
    
}
