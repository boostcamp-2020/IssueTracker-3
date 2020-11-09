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
    let milestoneID: String?
    let createdAt: String
    let closedAt: String?
    let labels: LabelList
    let assignee: AssigneeList
    let milestone: MilestoneList
    let comment: IssueComment

    enum CodingKeys: String, CodingKey {
        case id, title, body, state, labels, assignee, milestone, comment
        case userID = "user_id"
        case milestoneID = "milestone_id"
        case createdAt = "created_at"
        case closedAt = "closed_at"
    }
}
