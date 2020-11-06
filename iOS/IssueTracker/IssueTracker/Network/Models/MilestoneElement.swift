//
//  MilestoneElement.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/03.
//

import Foundation

// MARK: MilestoneElement

struct MilestoneElement: Codable {
    let id: Int
    let name: String
    let milestoneDescription: String
    let dueDate: String?
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case milestoneDescription = "description"
        case dueDate = "due_date"
        case createdAt = "created_at"
    }
}

typealias Milestone = [MilestoneElement]
