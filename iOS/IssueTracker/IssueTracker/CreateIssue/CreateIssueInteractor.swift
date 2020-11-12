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
    func editIssue(id: Int, title: String, comment: String, completion: @escaping () -> Void)
}

final class CreateIssueInteractor: CreateIssueDataStore {
    let networkService: NetworkServiceProvider = NetworkService()
    var createdIssue: Issue?
    private var issueID: Int?
    
    private func createIssue(id: Int = 0, title: String, comment: String) -> Issue {
        return Issue(id: id, title: title, body: comment)
    }
}

extension CreateIssueInteractor: CreateIssueBusinessLogic {
    func uploadIssue(title: String, comment: String) {
        createdIssue = createIssue(title: title, comment: comment)
        guard let data = createdIssue?.encoded() else {
            debugPrint("uploadIssue encoding error")
            return
        }
        networkService.request(apiConfiguration: CreateIssueEndPoint.upload(data)) { [weak self] result in
            switch result {
            case .failure(let error):
                debugPrint(error)
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

    func editIssue(id: Int, title: String, comment: String, completion: @escaping () -> Void) {
        createdIssue = createIssue(id: id, title: title, comment: comment)
        guard let data = createdIssue?.encoded() else {
            debugPrint("createIssue encoding error")
            return
        }

        networkService.request(apiConfiguration: CreateIssueEndPoint.edit(data)) { result in
            switch result {
            case .failure(let error):
                debugPrint(error)
                return
            case .success:
                completion()
                return
            }
        }
    }
    
    func uploadIssueComponents() {
        
    }
}
