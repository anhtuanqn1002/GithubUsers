//
//  Constants.swift
//  GithubUsers
//
//  Created by Anh Tuan on 7/3/19.
//  Copyright © 2019 tuan.nva. All rights reserved.
//

import Foundation

enum Constants {}

extension Constants {
    enum StringURL {
        static let root = "https://api.github.com"
        static let user = "/users"
        static let details = "/users/%@"
    }
}
