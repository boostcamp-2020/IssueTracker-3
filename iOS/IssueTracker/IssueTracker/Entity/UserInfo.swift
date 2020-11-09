//
//  UserInfo.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/09.
//

import Foundation

struct UserInfo: Codable {
    let state: String
    let token: String
    let userID: String
    
    enum CodingKeys: String, CodingKey {
        case state
        case token = "JWT"
        case userID = "user_id"
    }
}
