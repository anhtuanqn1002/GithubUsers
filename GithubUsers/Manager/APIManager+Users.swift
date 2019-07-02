//
//  APIManager+Users.swift
//  GithubUsers
//
//  Created by Anh Tuan on 7/3/19.
//  Copyright © 2019 tuan.nva. All rights reserved.
//

import Foundation

extension APIManager {
    struct Users {
        private init() {}
        
        static func getUsers(completion: @escaping (Network.Response) -> Void) {
            let url = APIManager.endpoint(path: Constants.StringURL.user)
            APIManager.request(method: .get, url: url, params: [:], completion: completion)
        }
    }
}
