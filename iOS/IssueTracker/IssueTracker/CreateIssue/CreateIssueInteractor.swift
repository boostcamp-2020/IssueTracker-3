//
//  CreateIssueInteractor.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/08.
//

import Foundation

protocol CreateIssueDataStore {
    var createdIssue: Issue? { get set }
}

protocol CreateIssueBusinessLogic {
    func uploadIssue()
}

final class CreateIssueInteractor: CreateIssueDataStore {
    let networkService: NetworkServiceProvider = NetworkService()
    var presenter: IssueListPresentationLogic?
    var createdIssue: Issue?
}

extension CreateIssueInteractor: CreateIssueBusinessLogic {
    func uploadIssue() {
        guard let data = try? createdIssue?.encoded() else {
            // Error 처리
            return
        }
        // post
        networkService.request(apiConfiguration: CreateIssueEndPoint.upload(data)) { [weak self] result in
            switch result {
            case .failure(_):
                print("create issue 실패")
                // Error 처리
                return
            case .success(let _):
                // 성공 처리
                return
            }
        }
        // patch - label 등 나머지
    }
}

//guard (200...299).contains() else {
//    result.send(completion: .failure(.error(message: "\(httpResponse.statusCode)")))
//    return
//}
//guard (400...499).contains(response)
