//
//  IssueListViewModel.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/04.
//

import UIKit

final class IssueFilterViewModel: Hashable {
    let title: Filter
    let chevronDirection: [ChevronDirection]
    let childTitle: String = ""
    let image: UIImage? = nil
    let childItem: [IssueFilterViewModel]
    let identifier = UUID()
    var isChevron: Bool
    var hasChildren: Bool
    var needsSeparator: Bool = true

    init(title: Filter,
         chevronDirection: [ChevronDirection],
         isChevron: Bool,
         hasChildren: Bool = false,
         childItem: [IssueFilterViewModel] = [],
         childTitle: String = "",
         image: UIImage? = nil) {
        self.title = title
        self.hasChildren = hasChildren
        self.childItem = childItem
        self.isChevron = isChevron

        for child in self.childItem {
              child.needsSeparator = false
          }

        self.childItem.last?.needsSeparator = true
        self.chevronDirection = chevronDirection
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    static func == (lhs: IssueFilterViewModel, rhs: IssueFilterViewModel) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
