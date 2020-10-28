//
//  APIRouter.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/10/28.
//

import Foundation
import Alamofire

protocol SignInEndPointProtocol {
    
}

//final class SignInEndPoint {
//    let networkManager = NetworkManager(sessionManager: Session())
//    let url = "http://api.boostcamp.com/auth/login"
//
//    func validateUser(user: User) -> Bool {
//        networkManager.request(url: url) { data in
//        }
//        return false
//    }
//}

struct SignInEndPointType: APIConfiguration {
    let user: User
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: RequestParams {
        return .body(["userID": user.userID , "password": user.password])
    }
    
    var path: String {
        return "/auth/login"
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.ProductionServer.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
//        switch parameters {
//        case .body (let params):
        let params = parameters // 원래 없었음
            // TODO: JSONEncoder()
        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
//        case .url (let params):
//            let queryParams = params.map { pair  in
//                return URLQueryItem(name: pair.key, value: "\(pair.value)")
//            }
//            var components = URLComponents(string:url.appendingPathComponent(path).absoluteString)
//            components?.queryItems = queryParams
//            urlRequest.url = components?.url
//        }
        return urlRequest
    }
}
