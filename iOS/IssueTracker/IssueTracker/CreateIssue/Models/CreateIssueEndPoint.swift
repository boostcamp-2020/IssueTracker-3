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
    
    var method: HTTPMethod {
        switch self {
        case .upload:
            return .post
        case .edit:
            return .patch
        }
    }
    
    var path: String {
        return "/issue"
    }
    
    var body: Data? {
        switch self {
        case .upload(let data):
            return data
        case .edit(let data):
            return data
        }
    }
}
