//
//  LabelElement.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/03.
//

import Foundation

// MARK: LabelElement

struct LabelElement: Codable {
    let name: String
    let labelDescription: String
    let color: String
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case name
        case labelDescription = "description"
        case color
        case createdAt = "created_at"
    }
}

typealias Label = [LabelElement]
