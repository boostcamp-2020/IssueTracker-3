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
        let request = try? convertible.asURLRequest()
        self.userData = (
            method: request?.method,
            path: request?.url,
            body: request?.httpBody
        )

        return .init(convertible: URLRequest(url: (convertible.urlRequest?.url)!),
                     underlyingQueue: DispatchQueue(label: ""),
                     serializationQueue: DispatchQueue(label: ""),
                     eventMonitor: nil,
                     interceptor: nil,
                     delegate: Session())
    }
}
