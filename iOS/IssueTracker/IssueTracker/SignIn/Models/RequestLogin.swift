//
//  RequestLogin.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/10.
//

import Foundation

struct RequestLogin: Codable {
    let state, jwt: String

     enum CodingKeys: String, CodingKey {
         case state
         case jwt = "JWT"
     }
}
