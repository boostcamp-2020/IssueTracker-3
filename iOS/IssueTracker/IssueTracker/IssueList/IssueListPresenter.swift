//
//  IssueListPresenter.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/09.
//

import Foundation

protocol IssueListPresentationLogic {
    func presentFetchedIssues(issues: IssueList)
}

final class IssueListPresenter: IssueListPresentationLogic {
    weak var viewController: IssueListDisplayLogic?

    func presentFetchedIssues(issues: IssueList) {
        DispatchQueue.main.async { [weak self] in
            let viewModel = issues.map { IssueListViewModel(issue: $0) }
            self?.viewController?.displayFetchedIssues(viewModel: viewModel)
        }
    }
}
