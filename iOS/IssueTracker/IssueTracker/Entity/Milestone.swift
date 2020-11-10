//
//  Milestone.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/08.
//

import Foundation

typealias MilestoneList = [Milestone]

struct Milestone: Codable {
    let id: Int
    let name: String
    let description: String
    let dueDate: String
    let createdAt: String
    let state: Int
    
    enum CodingKeys: String, CodingKey {
        case id, name, description
        case dueDate = "due_date"
        case createdAt = "created_at"
        case state
    }
}
