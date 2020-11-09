//
//  CreateIssueInteractor.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/08.
//

import Foundation

protocol CreateIssueInteractorBusinessLogic {
    
}

//final class CreateIssueInteractor: CreateIssueInteractorBusinessLogic {
//    func encodeNewIssue(issue: NewIssue) -> Data? {
//        return try? JSONEncoder().encode(createdIssue)
//    }
//
//    func uploadCreatedIssue() {
//        guard let url = URL(string: APIServer.baseURL) else {
//            return
//        }
//        var urlRequest = URLRequest(url: url)
//        urlRequest.httpBody =
        
//        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
//            guard error == nil else {
//                // error 처리
//                return
//            }
//            guard (200...299).contains() else {
//                result.send(completion: .failure(.error(message: "\(httpResponse.statusCode)")))
//                return
//            }
//            guard (400...499).contains(response)
//            guard let dataURL = dataURL else {
//                result.send(completion: .failure(.downloadFailed))
//                return
//            }
//
//
//        }.resume()
//        NetworkManager(sessionManager: AF).request(endPoint: CreateIssueEndPoint) { (_: Data?) in
//
//        }
//}

/*
 Use case
 1. 로그인
    id/pw -> vc -> interactor -> network manager -> ala -> server
    response -> 성공/실패 test -> (presenter/VM) -> VC -> View

 USE CASE endpoint마다
 url / HTTPMethod / body
 
 case signIn
 // get (id, pw)
 case signUp
 // post (user 정보)
 case issueList
 // get
 case label
 // get
 case milestone
 // get

*/
//}
