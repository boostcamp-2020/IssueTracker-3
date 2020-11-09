//
//  IssueListEndPoint.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/09.
//

import Foundation

enum IssueListEndPoint: APIConfiguration {
    case getIssues
    case changeState(Int, Int)
    
    var method: HTTPMethod {
        switch self {
        case .getIssues: return .get
        case .changeState: return .patch
        }
    }
    
    var path: String {
        switch self {
        case .getIssues: return "/issue"
        case .changeState(let id, let state): return "/issue/\(id)/state/\(state)"
        }
    }
    
    var body: Data? {
        switch self {
        case .getIssues: return nil
        case .changeState: return nil
        }
    }
}
