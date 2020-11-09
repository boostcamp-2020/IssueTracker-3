//
//  Milestone.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/08.
//

import Foundation

typealias MilestoneList = [MileStone]

struct Milestone: Codable {
    let id: Int
    let name: String
    let description: String
    let dueDate: String
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id, name, description
        case dueDate = "due_date"
        case createdAt = "created_at"
    }
}
