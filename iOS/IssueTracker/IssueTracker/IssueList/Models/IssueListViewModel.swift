//
//  IssuesViewModel.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/03.
//

import Foundation

struct IssueListViewModel: Hashable {
    let title: String
    let description: String
    let milestone: String
    let labels: [String]
    let identifier = UUID()

    init(title: String,
         description: String,
         milestone: String,
         labels: [String]
         ) {
        self.title = title
        self.description = description
        self.milestone = milestone
        self.labels = labels
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    static func == (lhs: IssueListViewModel, rhs: IssueListViewModel) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
