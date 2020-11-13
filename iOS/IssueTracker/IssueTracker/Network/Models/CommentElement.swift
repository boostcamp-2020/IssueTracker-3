//
//  CommentElement.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/03.
//

import Foundation

// MARK: CommentElement

struct CommentElement: Codable {
    let id: Int
    let body: String
    let createdAt: String
    let emoji: String?
    let loginID: String
    let img: String

    enum CodingKeys: String, CodingKey {
        case id, body
        case createdAt = "created_at"
        case emoji
        case loginID = "login_id"
        case img
    }
}

typealias Comment = [CommentElement]
