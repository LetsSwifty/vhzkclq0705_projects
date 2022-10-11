//
//  Address.swift
//  Chapter08-APITest
//
//  Created by 권오준 on 2022/10/11.
//

import Foundation

public let baseURL = "http://swiftapi.rubypaper.co.kr:2029/practice/"

enum Address: String {
    case getTime = "currentTime"
    case post1 = "echo"
    case post2 = "echoJSON"
}
