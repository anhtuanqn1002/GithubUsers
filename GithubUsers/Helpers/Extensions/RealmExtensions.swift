//
//  RealmExtensions.swift
//  GithubUsers
//
//  Created by Anh Tuan on 7/3/19.
//  Copyright © 2019 tuan.nva. All rights reserved.
//

import Foundation
import RealmSwift

extension Realm {
    func safeWrite(block: () -> Void) {
        refresh()
        if isInWriteTransaction {
            block()
            return
        }
        
        try? write {
            block()
        }
    }
}
