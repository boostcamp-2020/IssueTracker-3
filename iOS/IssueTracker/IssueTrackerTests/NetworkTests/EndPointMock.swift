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
    let body = UserTestModel(park: "jaehyun", song: "minkwan")

    var method: HTTPMethod {
        .get
    }

    var path: String {
        "/test"
    }

    func asURLRequest() throws -> URLRequest {
        let url = try APIServer.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))

        urlRequest.httpMethod = method.rawValue

        urlRequest.httpBody = try JSONEncoder().encode(body)

        return urlRequest
    }
}
