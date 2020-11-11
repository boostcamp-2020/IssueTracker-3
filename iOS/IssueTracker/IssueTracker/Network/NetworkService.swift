//
//  NetworkManager.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/10/28.
//

import Foundation

protocol NetworkServiceProvider {
    func request(apiConfiguration: APIConfiguration, handler: @escaping (Result<Data, NetworkError>) -> Void)
}

class NetworkService: NetworkServiceProvider {
    @KeyChain(key: "token") static var token: String
    private let session: URLSession
    
    init(with urlSession: URLSession = .init(configuration: .default)) {
        session = urlSession
    }
    
    func request(apiConfiguration: APIConfiguration, handler: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let urlRequest = try? configureURLRequest(apiConfiguration: apiConfiguration) else {
            handler(.failure(.invalidURL))
            return
        }
        session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                handler(.failure(.requestFailure(message: error.localizedDescription)))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                handler(.failure(.invalidResponse(message: "")))
                return
            }

            switch response.statusCode {
            case 100...199: // Informational
                handler(.failure(.informational(message: "\(response.statusCode)")))
                return
            case 200...299: // Success
                guard let data = data else {
                    print("no data")
                    handler(.failure(.invalidData(message: "data nil")))
                    return
                }
                handler(.success(data))
                return
            case 300...399: // Redirection
                handler(.failure(.redirection(message: "\(response.statusCode)")))
                return
            case 400...499: // Client Error
                handler(.failure(.clientError(message: "\(response.statusCode)")))
                return
            case 500...599: // Server Error
                handler(.failure(.serverError(message: "\(response.statusCode)")))
                return
            default:
                handler(.failure(.serverError(message: "\(response.statusCode)")))
                return
            }
        }.resume()
    }
    
    private func configureURLRequest(apiConfiguration: APIConfiguration) throws -> URLRequest {
        let url = try APIServer.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(apiConfiguration.path))
//         urlRequest.setValue("bearer \(token)", forHTTPHeaderField: "\(HTTPHeader.authentication)")
        urlRequest.httpMethod = "\(apiConfiguration.method)"
        urlRequest.setValue("\(ContentType.formEncode)", forHTTPHeaderField: "\(HTTPHeader.acceptType)")
//        urlRequest.setValue("\(ContentType.formEncode)", forHTTPHeaderField: "\(HTTPHeader.contentType)")
        urlRequest.httpBody = apiConfiguration.body
        return urlRequest
    }
}
