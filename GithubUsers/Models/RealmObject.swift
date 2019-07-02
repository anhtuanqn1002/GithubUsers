//
//  RealmObject.swift
//  GithubUsers
//
//  Created by Anh Tuan on 7/3/19.
//  Copyright © 2019 tuan.nva. All rights reserved.
//

import Foundation
import RealmSwift

class RealmObject: Object {
    @objc dynamic var id = ""
    
    override static func primaryKey() -> String {
        return "id"
    }
}

// MARK: - RealmUtils
extension RealmObject: RealmUtils {}
