//
//  EndPointMock.swift
//  IssueTrackerTests
//
//  Created by ParkJaeHyun on 2020/10/28.
//

import Foundation
@testable import Alamofire
@testable import IssueTracker

class EndPointMock: APIConfiguration {
    var method: HTTPMethod {
        .get
    }

    var path: String {
        "/test"
    }

    var parameters: RequestParams {
        .body(["park": "jaehyun", "song": "minkwan"])
    }

    func asURLRequest() throws -> URLRequest {
        let url = try IssueTrackerServer.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))

        urlRequest.httpMethod = method.rawValue

        if case let .body(params) = parameters {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        }

        return urlRequest
    }
}
