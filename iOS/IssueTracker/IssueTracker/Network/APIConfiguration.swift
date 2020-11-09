//
//  APIConfiguration.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/10/28.
//

import Foundation


protocol APIConfiguration {
    var method: HTTPMethod { get }
    var path: String { get }
    var body: Data? { get }
}

struct APIServer {
    static let baseURL = "http://101.101.210.34:3000"
}

enum HTTPMethod: CustomStringConvertible {
    case get
    case post
    case patch
    case delete
    
    var description: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        case .patch: return "PATCH"
        case .delete: return "DELETE"
        }
    }
}

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
