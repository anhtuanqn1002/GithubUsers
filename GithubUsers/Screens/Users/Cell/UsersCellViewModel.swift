//
//  UsersCellViewModel.swift
//  GithubUsers
//
//  Created by Anh Tuan on 7/3/19.
//  Copyright © 2019 tuan.nva. All rights reserved.
//

import Foundation

final class UsersCellViewModel {
    var avatarURLString: String
    var login: String
    var htmlURL: String
    
    init(model: User) {
        avatarURLString = model.avatarURL
        login = model.login
        htmlURL = model.htmlURL
    }
}
