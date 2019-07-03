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
        
        static func getUserDetails(id: String, completion: @escaping (Swift.Result<User, NSError>) -> Void) {
            let path = String(format: Constants.StringURL.details, id)
            let url = APIManager.endpoint(path: path)
            APIManager.request(method: .get, url: url, params: [:]) { (response) in
                switch response.result {
                case .failure(let error):
                    if error.code == -1009 {
                        if let user = User.find(id: id) {
                            completion(.success(user))
                        } else {
                            completion(.failure(NSError(domain: "GithubUsers", code: 99, userInfo: nil)))
                        }
                    } else {
                        completion(.failure(error))
                    }
                case .success(let json):
                    guard let id = User.createOrUpdate(json: json),
                        let user = User.find(id: id) else {
                        completion(.failure(NSError(domain: "GithubUsers", code: 99, userInfo: nil)))
                        return
                    }
                    completion(.success(user))
                }
            }
        }
    }
}
