//
//  MilestoneViewModel.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/11.
//

import Foundation

class MilestoneViewModel: Hashable {
    let milestoneButton: CustomButtonView
    let description: String
    let dueDate: String
    let percentage: String
    let openIssuesCount: String
    let closedIssuesCount: String
    let identifier = UUID()

    init(milestone: Milestone) {
        self.milestoneButton = CustomButtonView(type: .milestone, text: milestone.name, color: "#ffffff")
        self.description = milestone.description
        self.dueDate = milestone.dueDate
        self.percentage = String(MilestoneCalculator.percentage(of: milestone.id))
        self.openIssuesCount = String(MilestoneCalculator[milestone.id, .open])
        self.closedIssuesCount = String(MilestoneCalculator[milestone.id, .closed])
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    static func == (lhs: MilestoneViewModel, rhs: MilestoneViewModel) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
