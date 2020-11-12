//
//  IssueDetailEditViewModel.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/12.
//

import Foundation

struct IssueDetailEditViewModel: Hashable {
    let title: String
    let color: String?
    let assigneeID: Int?
    let labelID: Int?
    let milestoneID: Int?
    let identifier = UUID()
    let labels: CustomButtonView?
    let milestone: CustomButtonView?
    let assignee: CustomButtonView?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    static func == (lhs: IssueDetailEditViewModel, rhs: IssueDetailEditViewModel) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
