//
//  LoadableFromStoryboard.swift
//  GithubUsers
//
//  Created by Anh Tuan on 7/3/19.
//  Copyright © 2019 tuan.nva. All rights reserved.
//

import Foundation
import UIKit

protocol LoadableFromStoryboard: class {
    static var storyboard: UIStoryboard { get }
}

extension LoadableFromStoryboard where Self: UIViewController {
    static func instantiateFromStoryboard() -> Self? {
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as? Self
    }
}
