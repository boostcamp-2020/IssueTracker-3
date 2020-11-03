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
        issues.append(IssueListViewModel(title: "test1",
                                         description: "설명",
                                         milestone: "프로젝트1",
                                         labels: ["label1, label2"]))
        issues.append(IssueListViewModel(title: "test2",
                                         description: "설명",
                                         milestone: "프로젝트2",
                                         labels: ["label1, label2"]))
        issues.append(IssueListViewModel(title: "test3",
                                         description: "설명",
                                         milestone: "프로젝트3",
                                         labels: ["label1, label2"]))
        issues.append(IssueListViewModel(title: "ha",
                                         description: "설명",
                                         milestone: "프로젝트4",
                                         labels: ["label1, label2"]))
        issues.append(IssueListViewModel(title: "haha",
                                         description: "설명",
                                         milestone: "프로젝트5",
                                         labels: ["label1, label2"]))
    }
}
