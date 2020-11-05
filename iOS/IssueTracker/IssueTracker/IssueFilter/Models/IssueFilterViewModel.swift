//
//  IssueListViewModel.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/04.
//

import Foundation

struct IssueFilterViewModel: Hashable {
    let title: String
    let hasChildren: Bool
    let identifier = UUID()

    init(title: String? = nil, hasChildren: Bool = false) {
        self.title = title
        self.hasChildren = hasChildren
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    static func == (lhs: IssueListViewModel, rhs: IssueListViewModel) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
