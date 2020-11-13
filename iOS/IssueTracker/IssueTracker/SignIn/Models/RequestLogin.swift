//
//  RequestLogin.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/10.
//

import Foundation

struct RequestLogin: Codable {
    let id: Int
    let state: String
    let jwt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case state
        case jwt = "JWT"
    }
}
