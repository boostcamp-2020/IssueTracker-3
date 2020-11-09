//
//  Label.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/08.
//

import Foundation

struct Label: Codable {
    let id: Int?
    let issueID: Int?
    let labelID: Int?
    let name: String
    let description: String
    let color: String
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id, name, description, color
        case issueID = "issue_id"
        case labelID = "label_id"
        case createdAt = "created_at"
    }
}
