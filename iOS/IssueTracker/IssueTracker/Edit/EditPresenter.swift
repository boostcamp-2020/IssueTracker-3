//
//  EditPresenter.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/12.
//

import Foundation

protocol EditPresentationLogic {
    func presentFetchAllGetUser(issues: AllGetUserList)
    func presentFetchAllGetLabel(issues: LabelList)
    func presentFetchAllGetMilestone(issues: MilestoneList)

}

final class EditPresenter: EditPresentationLogic {
    weak var viewController: EditDisplayLogic?

    func presentFetchAllGetUser(issues: AllGetUserList) {
        let viewModel = issues.map({ IssueDetailEditViewModel(title: $0.loginID) })
        viewController?.displayFetchAllGetUser(viewModel: viewModel)
    }

    func presentFetchAllGetLabel(issues: LabelList) {
        let viewModel = issues.map({ IssueDetailEditViewModel(title: $0.name) })
        viewController?.displayFetchAllGetUser(viewModel: viewModel)

    }

    func presentFetchAllGetMilestone(issues: MilestoneList) {
        let viewModel = issues.map({ IssueDetailEditViewModel(title: $0.name) })
        viewController?.displayFetchAllGetUser(viewModel: viewModel)
    }
}
