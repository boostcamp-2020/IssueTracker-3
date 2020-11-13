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
        let viewModel = issues.map({ IssueDetailEditViewModel(title: $0.loginID,
                                                              color: nil,
                                                              assigneeID: $0.id,
                                                              labelID: nil,
                                                              milestoneID: nil,
                                                              labels: nil,
                                                              milestone: nil,
                                                              assignee: CustomButtonView(type: .label,
                                                                                         text: $0.loginID,
                                                                                         color: "#ffffff")
        ) })
        viewController?.displayFetchAll(viewModel: viewModel)
    }

    func presentFetchAllGetLabel(issues: LabelList) {
        let viewModel = issues.map({ IssueDetailEditViewModel(title: $0.name,
                                                              color: $0.color,
                                                              assigneeID: nil,
                                                              labelID: $0.id,
                                                              milestoneID: nil,
                                                              labels: CustomButtonView(type: .label,
                                                                                       text: $0.name,
                                                                                       color: $0.color),
                                                              milestone: nil,
                                                              assignee: nil) })
        viewController?.displayFetchAll(viewModel: viewModel)
    }

    func presentFetchAllGetMilestone(issues: MilestoneList) {
        let viewModel = issues.map({ IssueDetailEditViewModel(title: $0.name,
                                                              color: nil,
                                                              assigneeID: nil,
                                                              labelID: nil,
                                                              milestoneID: $0.id,
                                                              labels: nil,
                                                              milestone: CustomButtonView(type: .milestone,
                                                                                          text: $0.name,
                                                                                          color: "#ffffff"),
                                                              assignee: nil) })
        viewController?.displayFetchAll(viewModel: viewModel)
    }
}
