//
//  APIManager+Users.swift
//  GithubUsers
//
//  Created by Anh Tuan on 7/3/19.
//  Copyright © 2019 tuan.nva. All rights reserved.
//

import Foundation
import SwiftyJSON

extension APIManager {
    struct Users {
        private init() {}
        
        static func getUsers(completion: @escaping (Swift.Result<[User], NSError>) -> Void) {
            let url = APIManager.endpoint(path: Constants.StringURL.user)
            APIManager.request(method: .get, url: url, params: [:]) { (response) in
                switch response.result {
                case .failure(let error):
                    if error.code == -1009 {
                        completion(.success(User.all))
                    } else {
                        completion(.failure(error))
                    }
                case .success(let json):
                    let users: [User] = json.arrayValue.compactMap {
                        guard let id = User.createOrUpdate(json: $0) else { return nil }
                        return User.find(id: id)
                    }
                    completion(.success(users))
                }
            }
        }
    }
}
