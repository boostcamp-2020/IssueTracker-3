//
//  HTTPHeader.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/09.
//

import Foundation

enum HTTPHeader: CustomStringConvertible {
    case authentication
    case contentType
    case acceptType
//    case acceptEncoding
//    case string
    
    var description: String {
        switch self {
        case .authentication: return "Authorization"
        case .contentType: return "Accept-Encoding"
        case .acceptType: return "Content-Type"
//        case .acceptEncoding: return "Accept"
//        case .string: return "String"
        }
    }
}
