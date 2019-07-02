//
//  UIImageExtensions.swift
//  GithubUsers
//
//  Created by Anh Tuan on 7/3/19.
//  Copyright © 2019 tuan.nva. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func load(_ urlString: String?) {
        guard let url = urlString else {
            image = nil
            return
        }
        kf.setImage(with: URL(string: url), placeholder: UIImage(named: "defaultAvatar"))
    }
}
