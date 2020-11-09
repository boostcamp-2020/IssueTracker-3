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
    var createdIssue: Issue?
}

extension CreateIssueInteractor: CreateIssueBusinessLogic {
    func uploadIssue() {
        // post
        // patch - label
    }
}

extension Encodable {
        
}

//guard (200...299).contains() else {
//    result.send(completion: .failure(.error(message: "\(httpResponse.statusCode)")))
//    return
//}
//guard (400...499).contains(response)
