//
//  User.swift
//  GithubUsers
//
//  Created by Anh Tuan on 7/3/19.
//  Copyright © 2019 tuan.nva. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class User: RealmObject {
    @objc dynamic var login: String = ""
    @objc dynamic var avatarURL: String = ""
    @objc dynamic var htmlURL: String = ""
}

// MARK: - UpdateFromJSON
extension User: UpdateFromJSON {
    func update(json: JSON) {
        id = "\(json["id"].intValue)"
        login = json["login"].stringValue
        avatarURL = json["avatar_url"].stringValue
        htmlURL = json["html_url"].stringValue
    }
}
