//
//  NetworkManagerStub.swift
//  IssueTrackerTests
//
//  Created by ParkJaeHyun on 2020/10/28.
//

import Foundation
@testable import Alamofire
@testable import IssueTracker

final class SessionManagerStub: SessionManager {
    var urlRequest: URLRequest?
    var userData: (
        method: HTTPMethod?,
        path: URL?,
        body: Data?
    )?

    func request(_ convertible: URLRequestConvertible, interceptor: RequestInterceptor?) -> DataRequest {
        self.urlRequest = try? convertible.asURLRequest()

        let method = convertible.urlRequest?.method
        let path = convertible.urlRequest?.url
        let body = convertible.urlRequest?.httpBody

        self.userData = (
            method: method,
            path: path,
            body: body
        )

        return .init(convertible: URLRequest(url: (convertible.urlRequest?.url)!),
                     underlyingQueue: DispatchQueue(label: ""),
                     serializationQueue: DispatchQueue(label: ""),
                     eventMonitor: nil,
                     interceptor: nil,
                     delegate: Session())
    }
}
