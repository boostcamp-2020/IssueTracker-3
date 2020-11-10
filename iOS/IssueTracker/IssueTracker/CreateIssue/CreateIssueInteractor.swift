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
    func uploadIssue(title: String, comment: String)
}

final class CreateIssueInteractor: CreateIssueDataStore {
    let networkService: NetworkServiceProvider = NetworkService()
    var presenter: CreateIssuePresentationLogic?
    var createdIssue: Issue?
    private var issueID: Int?
    
    private func createIssue(title: String, comment: String) -> Issue {
        return Issue(title: title, body: comment)
    }
}

extension CreateIssueInteractor: CreateIssueBusinessLogic {
    func uploadIssue(title: String, comment: String) {
        createdIssue = createIssue(title: title, comment: comment)
        guard let data = try? createdIssue?.encoded() else {
            // Error 처리
            return
        }
        networkService.request(apiConfiguration: CreateIssueEndPoint.upload(data)) { [weak self] result in
            switch result {
            case .failure(let error):
                debugPrint(error)
                // Error 처리
                return
            case .success(let data):
                guard let decodedData: Int = try? data.decoded() else {
                    debugPrint("upload response decode 실패")
                    return
                }
                self?.issueID = decodedData
                // patch - label 등 나머지
                return
            }
        }
    }
    
    func uploadIssueComponents() {
        
    }
}

//guard (200...299).contains() else {
//    result.send(completion: .failure(.error(message: "\(httpResponse.statusCode)")))
//    return
//}
//guard (400...499).contains(response)
