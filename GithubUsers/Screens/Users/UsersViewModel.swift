//
//  UsersViewModel.swift
//  GithubUsers
//
//  Created by Anh Tuan on 7/3/19.
//  Copyright © 2019 tuan.nva. All rights reserved.
//

import Foundation

final class UsersViewModel {
    
    let isLoading: Variable<Bool> = Variable(false)
    
    var title: String {
        return "User List"
    }
    
    var numberOfCell: Int {
        return cellViewModels.count
    }
    
    private var users: [User] = []
    private var cellViewModels: [UsersCellViewModel] = []
    
    private let apiManager: APIUser
    
    init(apiManager: APIUser = APIManager.Users()) {
        self.apiManager = apiManager
    }
}

extension UsersViewModel {
    func getData(completion: (() -> Void)? = nil) {
        isLoading.value = true
        apiManager.getUsers { (response) in
            defer { self.isLoading.value = false } 
            switch response {
            case .failure(let error):
                Log(error)
                completion?()
            case .success(let users):
                self.users = users
                self.cellViewModels = users.map { UsersCellViewModel(model: $0) }
                completion?()
            }
        }
    }
    
    func cellViewModelAt(_ index: Int) -> UsersCellViewModel? {
        guard 0..<numberOfCell ~= index else { return nil }
        return cellViewModels[index]
    }
    
    func createDetailsViewModel(_ index: Int) -> DetailsViewModel? {
        guard 0..<numberOfCell ~= index else { return nil }
        return DetailsViewModel(user: users[index])
    }
}
