//
//  Issue.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/08.
//

import Foundation

typealias IssueList = [Issue]

struct Issue: Codable {
    let id: Int
    let title: String
    let body: String
    let userID: Int
    let state: Int
    let milestoneID: Int?
    let createdAt: String
    let closedAt: String?
    let labels: [Label]
    let assignee: [Assignee]
    let milestone: [MileStone]

    enum CodingKeys: String, CodingKey {
        case id, title, body, state, labels, assignee, milestone
        case userID = "user_id"
        case milestoneID = "milestone_id"
        case createdAt = "created_at"
        case closedAt = "closed_at"
    }
}
