//
//  IssueDetailPresenter.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/10.
//

import Foundation

protocol IssueDetailPresentationLogic {
    func presentFetchedComments(issues: CommentList)
}

final class IssueDetailPresenter: IssueDetailPresentationLogic {
    weak var viewController: IssueDetailDisplayLogic?

    func presentFetchedComments(issues: CommentList) {
            let viewModel = issues.map({ IssueDetailViewModel(commentList: $0) })
            viewController?.displayFetchedComments(viewModel: viewModel)
    }

    // change State

    // filter
}
