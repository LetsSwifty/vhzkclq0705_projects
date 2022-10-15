//
//  Address.swift
//  Chapter08-APITest
//
//  Created by 권오준 on 2022/10/11.
//

import Foundation

fileprivate let baseURL = "http://swiftapi.rubypaper.co.kr:2029/practice/"

enum Address {
    case getTime
    case post1
    case post2
    
    var url: String {
        switch self {
        case .getTime: return baseURL + "currentTime"
        case .post1: return baseURL + "echo"
        case .post2: return baseURL + "echoJSON"
        }
    }
}
