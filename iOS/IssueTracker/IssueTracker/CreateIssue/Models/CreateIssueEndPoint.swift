//
//  CreateIssueEndPoint.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/08.
//

import Foundation

enum CreateIssueEndPoint: APIConfiguration {
    case upload(Data)
    case edit(Data)
    case assignee(Data, Int)
    case label(Data, Int)

    var method: HTTPMethod {
        switch self {
        case .upload:
            return .post
        case .edit:
            return .patch
        case .assignee:
            return .patch
        case .label:
            return .patch
        }
    }
    
    var path: String {
        switch self {
        case .upload:
            return "/issue"
        case .edit:
            return "/issue"
        case .assignee(_, let id):
            return "/assignee/\(id)"
        case .label(_, let id):
            return "/tag/\(id)"
        }
    }
    
    var body: Data? {
        switch self {
        case .upload(let data):
            return data
        case .edit(let data):
            return data
        case .assignee(let data, _):
            return data
        case .label(let data, _):
            return data
        }
    }
}
