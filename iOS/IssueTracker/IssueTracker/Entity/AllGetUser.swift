//
//  AllGetUser.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/12.
//

import Foundation

typealias AllGetUserList = [AllGetUser]

struct AllGetUser: Codable {
    let id: Int
    let loginID, password: String
    let img: String
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case loginID = "login_id"
        case password, img
        case createdAt = "created_at"
    }
}
