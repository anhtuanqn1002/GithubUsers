//
//  DetailsViewModel.swift
//  GithubUsers
//
//  Created by Anh Tuan on 7/3/19.
//  Copyright © 2019 tuan.nva. All rights reserved.
//

import Foundation

final class DetailsViewModel {

    let isLoading: Variable<Bool> = Variable(false)
    
    private var user: User!

    var title: String {
        return "User profile"
    }
    
    var avatarString: String {
        return user.avatarURL
    }
    
    var username: String {
        return user.username
    }
    
    var location: String? {
        return user.location
    }
    
    var bio: String? {
        return user.bio
    }
    
    var publicRepo: String {
        return "\(user.publicRepo)"
    }
    
    var followers: String {
        return "\(user.followers)"
    }
    
    var following: String {
        return "\(user.following)"
    }
    
    init(user: User) {
        self.user = user
    }
}

// MARK: - Request data
extension DetailsViewModel {
    func getUserDetails(completion: (() -> Void)? = nil) {
        isLoading.value = true
        APIManager.Users.getUserDetails(id: user.id) { (response) in
            defer { self.isLoading.value = false }
            switch response {
            case .failure(let error):
                Log(error)
                completion?()
            case .success(let user):
                self.user = user
                completion?()
            }
        }
    }
}
