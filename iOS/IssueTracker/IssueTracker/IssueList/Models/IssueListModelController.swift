//
//  IssueListModelController.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/03.
//

import Foundation

final class IssueListModelController {
    func filteredBasedOnTitle(with filter: String, model: [IssueListViewModel]) -> [IssueListViewModel] {
        let filtered = model.filter { $0.contains(filter) }
        return filtered
    }

    func add(model: IssueListViewModel, to issueList: [IssueListViewModel]) -> [IssueListViewModel] {
        var issueListCopy = issueList
        issueListCopy.append(model)
        return issueListCopy
    }
}
