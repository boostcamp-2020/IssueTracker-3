//
//  APIRouter.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/10/28.
//

import Foundation

enum SignInEndPoint: APIConfiguration {
  case user(Data)
  case apple(Data)
  var method: HTTPMethod {
    return .get
  }
  var path: String {
    return "/auth/login"
  }
  var body: Data? {
    switch self {
    case .user(let data):
      return data
    case .apple(let data):
      return data
    }
  }
}
