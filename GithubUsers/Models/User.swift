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
    @objc dynamic var username: String = ""
    @objc dynamic var location: String?
    @objc dynamic var bio: String?
    @objc dynamic var publicRepo: Int = 0
    @objc dynamic var followers: Int = 0
    @objc dynamic var following: Int = 0
}

// MARK: - UpdateFromJSON
extension User: UpdateFromJSON {
    func update(json: JSON) {
        login = json["login"].stringValue
        avatarURL = json["avatar_url"].stringValue
        htmlURL = json["html_url"].stringValue
        username = json["name"].stringValue
        location = json["location"].string
        bio = json["bio"].string
        publicRepo = json["public_repos"].intValue
        followers = json["followers"].intValue
        following = json["following"].intValue
    }
}
