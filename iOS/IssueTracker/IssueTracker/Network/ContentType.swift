//
//  ContentType.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/09.
//

import Foundation

enum ContentType: CustomStringConvertible {
    case json
    case formEncode
    
    var description: String {
        switch self {
        case .formEncode: return "Application/json"
        case .json: return "application/x-www-form-urlencoded"
        }
    }
}
