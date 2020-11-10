//
//  IssuesViewModel.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/03.
//

import UIKit

struct IssueListViewModel: Hashable {
    let id: Int
    let title: String
    let description: String
    let milestone: CustomButtonView
    let labels: [CustomButtonView]
    let isOpen: Bool
//    let author: String
    let identifier = UUID()

    init(id: Int,
         title: String,
         description: String,
         milestone: CustomButtonView,
         labels: [CustomButtonView],
         isOpen: Bool = false
//         author: String
         ) {
        self.id = id
        self.title = title
        self.description = description
        self.milestone = milestone
        self.labels = labels
        self.isOpen = isOpen
//        self.author = author
    }
    
    init(issue: Issue) {
        id = issue.id
        title = issue.title
        description = issue.body
        isOpen = issue.state == 1 ? true : false
        milestone = CustomButtonView(type: .milestone, text: issue.milestone?.first?.name ?? "", color: "#ffffff")
        labels = issue.labels?
            .compactMap { CustomButtonView(type: .label, text: $0.description, color: $0.color) } ?? [CustomButtonView()]
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    static func == (lhs: IssueListViewModel, rhs: IssueListViewModel) -> Bool {
        return lhs.identifier == rhs.identifier
    }

    func contains(_ filter: String?) -> Bool {
        guard let filterText = filter else { return true }
        if filterText.isEmpty { return true }
        let lowercasedFilter = filterText.lowercased()
        return title.lowercased().contains(lowercasedFilter)
    }
}
