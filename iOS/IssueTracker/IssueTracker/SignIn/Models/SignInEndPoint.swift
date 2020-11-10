//
//  APIRouter.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/10/28.
//

import Foundation

enum SignInEndPoint: APIConfiguration {
    case signIn(Data)
    case signUp(Data)
    case apple(Data)
    case github

    var method: HTTPMethod {
        //        switch self {
        //        case .signIn: return .post
        //        case .signUp(_): return .post
        //        case .apple(_): return .post
        //        case .github: return .post
        //        }
        return .post
    }

    var path: String {
        switch self {
        case .signIn: return "/auth/login"
        case .signUp: return "/auth/register"
        case .apple: return "/auth/apple"
        case .github: return "/auth/github"
        }
    }

    var body: Data? {
        switch self {
        case .signIn(let data): return data
        case .signUp(let data): return data
        case .apple(let data): return data
        case .github: return nil
        }
    }
}
