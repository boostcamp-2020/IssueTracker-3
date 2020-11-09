//
//  Assignee.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/08.
//

import Foundation

struct Assignee: Codable {
    let id: Int
    let issueID: Int
    let userID: Int
    let loginID: String
    let password: String
    let img: String
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id, password, img
        case issueID = "issue_id"
        case userID = "user_id"
        case loginID = "login_id"
        case createdAt = "created_at"
    }
}
