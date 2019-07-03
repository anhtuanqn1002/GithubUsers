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

    let title = Variable("Profile")
    let avatarString = Variable("")
    let username = Variable("")
    let location: Variable<String?> = Variable(nil)
    let bio: Variable<String?> = Variable(nil)
    let publicRepo = Variable("")
    let followers = Variable("")
    let following = Variable("")
    
    private let apiManager: APIUser

    init(user: User, apiManager: APIUser = APIManager.Users()) {
        self.user = user
        self.apiManager = apiManager
    }
}

// MARK: - Request data
extension DetailsViewModel {
    func getUserDetails(completion: (() -> Void)? = nil) {
        isLoading.value = true
        apiManager.getUserDetails(id: user.id) { [weak self] (response) in
            guard let self = self else { return }
            defer { self.isLoading.value = false }
            switch response {
            case .failure(let error):
                Log(error)
                completion?()
            case .success(let user):
                self.user = user
                self.updateData()
                completion?()
            }
        }
    }
    
    private func updateData() {
        avatarString.value = user.avatarURL
        username.value = user.username
        location.value = user.location
        bio.value = user.bio
        publicRepo.value = "\(user.publicRepo)"
        followers.value = "\(user.followers)"
        following.value = "\(user.following)"
    }
}
