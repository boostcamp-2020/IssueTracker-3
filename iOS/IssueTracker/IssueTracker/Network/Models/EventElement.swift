//
//  EventElement.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/04.
//

import Foundation

// MARK: - EventElement
struct EventElement: Codable {
    let id: Int
    let issueID: Int
    let userID: Int
    let log: String
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case issueID = "issue_id"
        case userID = "user_id"
        case log
        case createdAt = "created_at"
    }
}

typealias Event = [EventElement]
