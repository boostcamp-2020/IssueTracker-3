//
//  APIRouter.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/10/28.
//

import Foundation
import Alamofire
//
//enum SignInEndPoint: APIConfiguration {
//    case user(User)
//    case apple(AppleModel)
//
//    var method: HTTPMethod {
//        return .get
//    }
//
//    var parameters: RequestParams {
//        switch self {
//        case .apple(let data):
//            return .body(data.toJson())
//        case .user(let data):
//            return .body(data.toJson())
//        }
//    }
//
//    var path: String {
//        return "/auth/login"
//    }
//
//    func asURLRequest() throws -> URLRequest {
//        let url = try APIServer.baseURL.asURL()
//
//        var urlRequest: URLRequest = {
//            var urlRequest = URLRequest(url: url.appendingPathComponent(path))
//            urlRequest.httpMethod = method.rawValue
//            urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeader.acceptType.rawValue)
//            urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeader.contentType.rawValue)
//            return urlRequest
//        }()
//
//
//        switch parameters {
//        case .body(let params):
//            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
//            return urlRequest
//        }
//
//        return urlRequest
//    }
//}
//
//extension Data {
//    func decoded<T: Decodable>() throws -> T {
//        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
//        return try decoder.decode(T.self, from: self)
//    }
//}
