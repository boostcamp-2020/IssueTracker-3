//
//  User.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/08.
//

import Foundation

struct User: Codable {
    let userID: String?
    let password: String?
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case password
    }
}
