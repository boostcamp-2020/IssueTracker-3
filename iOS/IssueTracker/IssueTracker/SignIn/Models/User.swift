//
//  User.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/05.
//

import Foundation

struct User {
    let userID: String
    let password: String

    func toJson() -> [String: Any] {
        return [
            "user_id" : userID,
            "password" : password
        ]
    }
}
