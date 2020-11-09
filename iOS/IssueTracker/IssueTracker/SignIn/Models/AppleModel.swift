//
//  appleModel.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/08.
//

import Foundation

struct AppleModel: Codable {
    let authorizationCode: String
    let identityToken: String

    func toJson() -> [String: Any] {
        return [
            "authorization_code": authorizationCode,
            "identity_token": identityToken
        ]
    }
}
