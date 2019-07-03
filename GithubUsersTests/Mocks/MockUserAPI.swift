//
//  MockUserAPI.swift
//  GithubUsersTests
//
//  Created by Anh Tuan on 7/3/19.
//  Copyright © 2019 tuan.nva. All rights reserved.
//

import Foundation
@testable import GithubUsers

class MockUserAPI: APIUser {
    func getUserDetails(id: String, completion: @escaping (Result<User, NSError>) -> Void) {
        let user = User()
        user.followers = 10
        user.following = 22
        completion(.success(user))
    }
    
    func getUsers(completion: @escaping (Result<[User], NSError>) -> Void) {
        completion(.success([User()]))
    }
}
