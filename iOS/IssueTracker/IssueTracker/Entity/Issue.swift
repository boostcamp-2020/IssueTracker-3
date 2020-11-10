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
    let milestoneID: MilestoneID?
    let createdAt: String?
    let closedAt: String?
    let labels: LabelList?
    let assignee: AssigneeList?
    let milestone: MilestoneList?
    let comment: IssueComment?
    
    init(id: Int = 0,
         title: String,
         body: String,
         userID: Int = 1,
         state: Int = 1,
         milestoneID: MilestoneID? = .integer(0),
         createdAt: String? = nil,
         closedAt: String? = nil,
         labels: LabelList? = nil,
         assignee: AssigneeList? = nil,
         milestone: MilestoneList? = nil,
         comment: IssueComment? = nil) {
        self.id = id
        self.title = title
        self.body = body
        self.userID = userID
        self.state = state
        self.milestoneID = milestoneID
        self.createdAt = createdAt
        self.closedAt = closedAt
        self.labels = labels
        self.assignee = assignee
        self.milestone = milestone
        self.comment = comment
    }

    enum CodingKeys: String, CodingKey {
        case id, title, body, state, labels, assignee, milestone, comment
        case userID = "user_id"
        case milestoneID = "milestone_id"
        case createdAt = "created_at"
        case closedAt = "closed_at"
    }
}

enum MilestoneID: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(MilestoneID.self,
                                         DecodingError.Context(codingPath: decoder.codingPath,
                                                               debugDescription: "Wrong type for MilestoneID"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}
