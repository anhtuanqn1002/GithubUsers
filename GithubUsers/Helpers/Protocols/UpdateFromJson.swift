//
//  UpdateFromJson.swift
//  GithubUsers
//
//  Created by Anh Tuan on 7/3/19.
//  Copyright © 2019 tuan.nva. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol UpdateFromJSON {
    func update(json: JSON)
}
