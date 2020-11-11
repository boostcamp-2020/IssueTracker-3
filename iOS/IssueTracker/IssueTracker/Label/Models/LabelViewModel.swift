//
//  LabelViewModel.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/10.
//

import Foundation

class LabelViewModel: Hashable {
    let id: Int?
    let description: String
    let labelButton: CustomButtonView
    let identifier = UUID()

    init(label: Label) {
        self.id = label.id
        self.description = label.description
        self.labelButton = CustomButtonView(type: .label, text: label.name, color: label.color)
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    static func == (lhs: LabelViewModel, rhs: LabelViewModel) -> Bool {
        return lhs.identifier == rhs.identifier
    }

}
