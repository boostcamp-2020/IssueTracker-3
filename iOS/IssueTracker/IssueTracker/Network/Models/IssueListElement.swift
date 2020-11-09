//
//  IssueListElement.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/03.
//

import Foundation

// MARK: IssueListElement

struct IssueListElement: Codable {
    let id: Int
    let title: String
    let body: String
    let userID: Int
    let state: Int
    let milestoneID: Int?
    let createdAt: String
    let closedAt: String?
    let labels: [IssueLabel]
    let assignee: [IssueAssignee]
    let milestone: [Milestone]

    enum CodingKeys: String, CodingKey {
        case id, title, body
        case userID = "user_id"
        case state
        case milestoneID = "milestone_id"
        case createdAt = "created_at"
        case closedAt = "closed_at"
        case labels, assignee, milestone
        
    }
}

// MARK: - Assignee
struct IssueAssignee: Codable {
    let id, issueID, userID: Int
    let loginID, password, img, createdAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case issueID = "issue_id"
        case userID = "user_id"
        case loginID = "login_id"
        case password, img
        case createdAt = "created_at"
    }
}

// MARK: - Label
struct IssueLabel: Codable {
    let id, issueID, labelID: Int
    let name, labelDescription, color, createdAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case issueID = "issue_id"
        case labelID = "label_id"
        case name
        case labelDescription = "description"
        case color
        case createdAt = "created_at"
    }
}

// MARK: - Milestone
struct IssueMilestone: Codable {
    let id: Int
    let name, milestoneDescription, dueDate, createdAt: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case milestoneDescription = "description"
        case dueDate = "due_date"
        case createdAt = "created_at"
    }
}

typealias IssueList = [IssueListElement]
