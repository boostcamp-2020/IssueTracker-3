//
//  MilestoneViewModel.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/11.
//

import Foundation

class MilestoneViewModel: Hashable {
    let description: String
    let milestoneButton: CustomButtonView
    let identifier = UUID()

    init(milestone: Milestone) {
        self.description = milestone.description
        self.milestoneButton = CustomButtonView(type: .milestone, text: milestone.name, color: "#ffffff")
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    static func == (lhs: MilestoneViewModel, rhs: MilestoneViewModel) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
