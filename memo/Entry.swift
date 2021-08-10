//
//  Entry.swift
//  memo
//
//  Created by Diego Freniche Brito on 20/02/2021.
//

import Foundation
import RealmSwift

class Entry: RealmSwift.Object {
    @objc dynamic var text: String = ""
    @objc dynamic var timestamp = Date()
}
