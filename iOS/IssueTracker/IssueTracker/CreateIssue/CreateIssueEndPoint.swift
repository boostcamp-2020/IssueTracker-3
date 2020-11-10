//
//  CreateIssueEndPoint.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/08.
//

import Foundation

enum CreateIssueEndPoint: APIConfiguration {
    case upload(Data)
    
    var method: HTTPMethod {
        return .post
    }
    
    var path: String {
        return "/issue"
    }
    
    var body: Data? {
        switch self {
        case .upload(let data):
            return data
        }
    }
}
