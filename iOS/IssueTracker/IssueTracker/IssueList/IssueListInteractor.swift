//
//  IssueListInteractor.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/09.
//

import Foundation

protocol IssueListDataStore {
    var issues: IssueList { get set }
}

protocol IssueListBusinessLogic {
    func fetchIssues()
    func changeIssueState()
    //
    func filtered(with filter: String, model: [IssueListViewModel])
}

final class IssueListInteractor: IssueListDataStore {
    let networkService: NetworkServiceProvider = NetworkService()
    var presenter: IssueListPresentationLogic?
    var issues = IssueList()
}

extension IssueListInteractor: IssueListBusinessLogic {
    func changeIssueState() {
        
    }
    
    func fetchIssues() {
        networkService.request(apiConfiguration: IssueListEndPoint.getIssues) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                debugPrint(error)
                return
            case .success(let data):
                guard let decodedData: IssueList = try? data.decoded() else {
                    debugPrint("decode 실패")
                    return
                }
                self.issues = decodedData
                self.presenter?.presentFetchedIssues(issues: self.issues)
                self.classifyIssues()
            }
        }
    }
    
    func closeIssues() {
        
    }

    func classifyIssues() {
        issues.forEach { issue in
            guard let milestoneID = issue.milestoneID else { return }
            MilestoneCalculator.input(milestoneID: milestoneID, issueState: issue.state)
        }
    }
    
    //
    func filtered(with filter: String, model: [IssueListViewModel]) {
        // let filtered = model.filter { $0.contains(filter) }
        // return filtered
    }

    //
    func add(model: IssueListViewModel, to issueList: [IssueListViewModel]) -> [IssueListViewModel] {
        var issueListCopy = issueList
        issueListCopy.append(model)
        return issueListCopy
    }
}
