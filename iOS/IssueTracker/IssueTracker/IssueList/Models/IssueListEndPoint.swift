//
//  IssueListEndPoint.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/07.
//

import Foundation
import Alamofire

enum IssueListEndPoint: APIConfiguration {
    case getIssue
    case changeState(Int, Int)

    var method: HTTPMethod {
        switch self {
        case .getIssue: return .patch
        case .changeState: return .get
        }
        //        return .patch state => open close
    }

    var parameters: RequestParams {
        switch self {
        case .getIssue:
            return .body([:])
        case .changeState(let id, let state):
            return .body([:])
        }
    }

    var path: String {
        switch self {
        case .getIssue: return "/issue"
        case .changeState(let id, let state): return "/issue/\(id)/state/\(state)"
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = try APIServer.baseURL.asURL()

        let urlRequest: URLRequest = {
            var urlRequest = URLRequest(url: url.appendingPathComponent(path))
            urlRequest.httpMethod = method.rawValue
            urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeader.acceptType.rawValue)
            urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeader.contentType.rawValue)
            return urlRequest
        }()

        return urlRequest
    }
}
