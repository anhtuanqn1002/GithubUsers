//
//  UsersViewModel.swift
//  GithubUsers
//
//  Created by Anh Tuan on 7/3/19.
//  Copyright © 2019 tuan.nva. All rights reserved.
//

import Foundation

final class UsersViewModel {
    
    var title: String {
        return "User List"
    }
    
    var numberOfCell: Int {
        return cellViewModels.count
    }
    
    private var cellViewModels: [UsersCellViewModel] = []
}

extension UsersViewModel {
    func getData(completion: (() -> Void)? = nil) {
        APIManager.Users.getUsers { (response) in
            switch response {
            case .failure(let error):
                Log(error)
                completion?()
            case .success(let users):
                self.cellViewModels = users.map { UsersCellViewModel(model: $0) }
                completion?()
            }
        }
    }
    
    func cellViewModelAt(_ index: Int) -> UsersCellViewModel? {
        guard 0..<numberOfCell ~= index else { return nil }
        return cellViewModels[index]
    }
}
