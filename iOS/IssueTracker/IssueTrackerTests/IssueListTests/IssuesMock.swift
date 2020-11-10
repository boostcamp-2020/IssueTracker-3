//
//  IssuesMock.swift
//  IssueTrackerTests
//
//  Created by ParkJaeHyun on 2020/11/03.
//

import Foundation
@testable import IssueTracker

class IssuesMock {
    var issues = [IssueListViewModel]()

    init() {
        generatedModel()
    }

    func generatedModel() {
        issues.append(IssueListViewModel(
                        id: 1,
                        title: "test",
                        description: "설명",
                        milestone: CustomButtonView(type: .milestone,
                                                    text: "프로젝트",
                                                    color: "#ffffff"),
                        labels: [CustomButtonView(type: .label,
                                                  text: "label",
                                                  color: "#ffffff"),
                                 CustomButtonView(type: .label,
                                                  text: "labe",
                                                  color: "#ffffff")]))
        issues.append(IssueListViewModel(
                        id: 1,
                        title: "test1",
                        description: "설명",
                        milestone: CustomButtonView(type: .milestone,
                                                    text: "프로젝트",
                                                    color: "#ffffff"),
                        labels: [CustomButtonView(type: .label,
                                                  text: "label",
                                                  color: "#ffffff"),
                                 CustomButtonView(type: .label,
                                                  text: "labe",
                                                  color: "#ffffff")]))
        issues.append(IssueListViewModel(
                        id: 1,
                        title: "test2",
                        description: "설명",
                        milestone: CustomButtonView(type: .milestone,
                                                    text: "프로젝트",
                                                    color: "#ffffff"),
                        labels: [CustomButtonView(type: .label,
                                                  text: "label",
                                                  color: "#ffffff"),
                                 CustomButtonView(type: .label,
                                                  text: "labe",
                                                  color: "#ffffff")]))
        (1...10).forEach { number in
            issues.append(IssueListViewModel(
                            id: 1,
                            title: "haha\(number)",
                            description: "설명",
                            milestone: CustomButtonView(type: .milestone,
                                                        text: "프로젝트",
                                                        color: "#ffffff"),
                            labels: [CustomButtonView(type: .label,
                                                      text: "label\(number)",
                                                      color: "#ffffff"),
                                     CustomButtonView(type: .label,
                                                      text: "labe\(number)",
                                                      color: "#ffffff")]))
    }
    }
}
