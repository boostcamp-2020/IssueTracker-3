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
    typealias Data = UserTestModel
    
    var method: HTTPMethod {
        .get
    }
    
    var parameters: RequestParams<Data> {
        .body(UserTestModel(park: "jaehyun", song: "minkwan"))
    }

    var path: String {
        "/test"
    }

    func asURLRequest() throws -> URLRequest {
        let url = try APIServer.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))

        urlRequest.httpMethod = method.rawValue

        if case let .body(params) = parameters {
            urlRequest.httpBody = try JSONEncoder().encode(params)
        }

        return urlRequest
    }
}
