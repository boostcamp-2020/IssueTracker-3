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
    case getAllUser

    var method: HTTPMethod {
        switch self {
        case .upload:
            return .post
        case .edit:
            return .patch
        case .getAllUser:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .upload:
            return "/issue"
        case .edit:
            return "/issue"
        case .getAllUser:
            return "/auth/alluser"
        }
    }
    
    var body: Data? {
        switch self {
        case .upload(let data):
            return data
        case .edit(let data):
            return data
        case .getAllUser:
            return nil
        }
    }
}
