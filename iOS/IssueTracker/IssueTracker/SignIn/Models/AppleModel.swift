//
//  appleModel.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/08.
//

import Foundation

struct AppleLogin: Codable {
    let authorizationCode: String
    let identityToken: String
}
