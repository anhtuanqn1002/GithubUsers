//
//  RealmUtils.swift
//  GithubUsers
//
//  Created by Anh Tuan on 7/3/19.
//  Copyright © 2019 tuan.nva. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

protocol RealmUtils {}

extension RealmUtils where Self: RealmObject {
    static var all: [Self] {
        guard let realm = try? Realm() else { return [] }
        realm.refresh()
        return Array(realm.objects(self))
    }
    
    static func find(id: String) -> Self? {
        guard let realm = try? Realm() else { return nil }
        realm.refresh()
        return all.first(where: { $0.id == id })
    }
    
    static func delete(id: String) {
        guard let realm = try? Realm(),
            let object = find(id: id)
            else { return }
        
        realm.safeWrite {
            realm.delete(object)
        }
    }
    
    @discardableResult
    static func createOrUpdate(json: JSON) -> String? {
        guard let realm = try? Realm(),
            let idInt = json["id"].int
            else { return nil }
        let id = "\(idInt)"
        realm.safeWrite {
            let object = find(id: id) ?? self.init()
            if object.realm == nil {
                object.id = id
            }
            (object as? UpdateFromJSON)?.update(json: json)
            realm.add(object, update: .modified)
        }
        return id
    }
}
