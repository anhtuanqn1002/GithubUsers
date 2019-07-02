//
//  Log.swift
//  GithubUsers
//
//  Created by Anh Tuan on 7/2/19.
//  Copyright © 2019 tuan.nva. All rights reserved.
//

import Foundation

func Log(_ s: Any?, file: String = #file, _ function: String = #function, line: Int = #line) {
    #if DEBUG
    let fileName = file.components(separatedBy: "/").last!
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm:ss"
    let date = dateFormatter.string(from: Date())
    let queue = Thread.current.isMainThread ? "Main Thread" : (Thread.current.name ?? "Unknown Thread")
    print("✅ [\(date) {\(queue)} \(fileName) > \(function) L\(line)] \(s ?? "nil")")
    #endif
}
