//
//  IssueDetailEditViewModel.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/12.
//

import Foundation

struct IssueDetailEditViewModel: Hashable {
    let title: String
    let identifier = UUID()

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    static func == (lhs: IssueDetailEditViewModel, rhs: IssueDetailEditViewModel) -> Bool {
        return lhs.identifier == rhs.identifier
    }

    
}
