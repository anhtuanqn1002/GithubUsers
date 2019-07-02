//
//  User.swift
//  GithubUsers
//
//  Created by Anh Tuan on 7/3/19.
//  Copyright © 2019 tuan.nva. All rights reserved.
//

import Foundation
import SwiftyJSON

struct User {
    var id: Int
    var login: String
    var avatarURL: String
    var htmlURL: String
    
    init(json: JSON) {
        id = json["id"].intValue
        login = json["login"].stringValue
        avatarURL = json["avatar_url"].stringValue
        htmlURL = json["html_url"].stringValue
    }
}
