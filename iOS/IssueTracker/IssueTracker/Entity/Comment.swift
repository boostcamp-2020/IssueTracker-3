//
//  Comment.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/08.
//

import Foundation

struct Comment: Codable {
    let id: Int
    let userID: Int
    let body: String
    let emoji: String
    let issueID: Int
    let createdAt: String
    let title: String
    let state: Int
    let milestoneID: String
    let closedAt: String

    enum CodingKeys: String, CodingKey {
        case id, body, emoji, title, state
        case userID = "user_id"
        case createdAt = "created_at"
        case issueID = "issue_id"
        case milestoneID = "milestone_id"
        case closedAt = "closed_at"
    }
}
