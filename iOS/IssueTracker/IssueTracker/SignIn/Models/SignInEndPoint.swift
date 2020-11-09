//
//  APIRouter.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/10/28.
//

import Foundation
import Alamofire

enum SignInEndPoint: APIConfiguration {
    case user(User)
    case apple(AppleModel)

    var method: HTTPMethod {
        return .get
    }

    var parameters: RequestParams {
        switch self {
        case .apple(let data):
            return .body(data.toJson())
        case .user(let data):
            return .body(data.toJson())
        }
    }

    var path: String {
        return "/auth/login"
    }
}
