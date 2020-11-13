//
//  IssueDetailEndPoint.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/09.
//

import Foundation

enum IssueDetailEndPoint: APIConfiguration {
    case getComments(Int)
    case postComment(Data)

    var method: HTTPMethod {
        switch self {
        case .getComments:
            return .get
        case .postComment:
            return .post
        }
    }

    var path: String {
        switch self {
        case .getComments(let id):
            return "/comment/\(id)"
        case .postComment:
            return "/comment"
        }
    }

    var body: Data? {
        switch self {
        case .getComments:
            return nil
        case .postComment(let data):
            return data
        }
    }
}
