//
//  IssueDetailEditEndPoint.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/12.
//

import Foundation

enum IssueDetailEditEndPoint: APIConfiguration {
    case getAllUser

    var method: HTTPMethod {
        switch self {
        case .getAllUser:
            return .get
        }
    }

    var path: String {
        switch self {
        case .getAllUser:
            return "/auth/alluser"
        }
    }

    var body: Data? {
        switch self {
        case .getAllUser:
            return nil
        }
    }
}
