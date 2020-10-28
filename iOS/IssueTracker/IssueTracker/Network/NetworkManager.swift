//
//  NetworkManager.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/10/28.
//

import Foundation
import Alamofire
import os

class NetworkManager {
    let session: SessionManager
    
    init(sessionManager: SessionManager) {
        self.session = sessionManager
    }
    
    func request(endPoint: URLRequestConvertible, handler: @escaping (Data?) -> Void) {
        session.request(endPoint, interceptor: nil).response { response in
            switch response.result {
            case .success(let response):
                handler(response)
            case .failure(let error):
                os_log("%@", error.localizedDescription)
            }
        }
    }
}

protocol SessionManager {
    func request(_ convertible: URLRequestConvertible, interceptor: RequestInterceptor?) -> DataRequest
}

extension Session: SessionManager {
    
}
