//
//  IssueDetailEndPoint.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/09.
//

import Foundation

enum IssueDetailEndPoint: APIConfiguration {
    case getComments(Int)

    var method: HTTPMethod {
        switch self {
        case .getComments: return .get
        }
    }

    var path: String {
        switch self {
        case .getComments(let id): return "/comment/\(id)"
        }
    }

    var body: Data? {
        switch self {
        case .getComments: return nil
        }
    }
}
