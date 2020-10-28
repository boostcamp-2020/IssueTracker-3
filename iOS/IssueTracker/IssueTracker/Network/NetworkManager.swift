//
//  NetworkManager.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/10/28.
//

import Foundation
import Alamofire

class NetworkManager {
    let session: SessionManager

    init(sessionManager: SessionManager) {
        self.session = sessionManager
    }

    // TODO: EndPoint 만들기
    func request(url: String, completionHandler: @escaping (Data?) -> Void) {

        let alamofire = session.request(url,
                                        method: .get,
                                        parameters: nil,
                                        encoding: URLEncoding.default,
                                        headers: nil,
                                        interceptor: nil,
                                        requestModifier: nil)

        alamofire.response { response in
            switch response.result {
            case .success(let value):
                completionHandler(value)
            case .failure(let error):
                print(error)
            }
        }
    }
}

protocol SessionManager {
    func request(_ convertible: URLConvertible,
                 method: HTTPMethod,
                 parameters: Parameters?,
                 encoding: ParameterEncoding,
                 headers: HTTPHeaders?,
                 interceptor: RequestInterceptor?,
                 requestModifier: Session.RequestModifier?) -> DataRequest
}

extension Session: SessionManager {

}
