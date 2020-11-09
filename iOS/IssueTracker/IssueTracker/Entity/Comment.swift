//
//  Comment.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/08.
//

import Foundation

struct Comment: Codable {
    let id: Int
    let body: String
    let createdAt: String
    let emoji: String?
    let loginID: String
    let image: String

    enum CodingKeys: String, CodingKey {
        case id, body, emoji
        case createdAt = "created_at"
        case loginID = "login_id"
        case image = "img"
    }
}
