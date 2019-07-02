//
//  Loadable.swift
//  GithubUsers
//
//  Created by Anh Tuan on 7/3/19.
//  Copyright © 2019 tuan.nva. All rights reserved.
//

import UIKit

protocol ReuseIdentifier {}

extension ReuseIdentifier where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UITableViewCell: ReuseIdentifier {}
extension UICollectionViewCell: ReuseIdentifier {}
