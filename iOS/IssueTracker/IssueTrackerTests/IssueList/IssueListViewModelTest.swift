//
//  IssueListViewModelTest.swift
//  IssueTrackerTests
//
//  Created by ParkJaeHyun on 2020/11/09.
//

import XCTest
@testable import IssueTracker

class IssueListViewModelTest: XCTestCase {

    func test_IssueListViewModel() throws {
        //Given
        let label1 = Label(id: 1,
                          issueID: 1,
                          labelID: 1,
                          name: "test",
                          description: "test",
                          color: "#FFFFFF",
                          createdAt: "20201109")
        let label2 = Label(id: 1,
                          issueID: 1,
                          labelID: 1,
                          name: "test",
                          description: "test",
                          color: "#000000",
                          createdAt: "20201109")

        let issue = Issue(id: 1,
                           title: "testModel",
                           body: "testBody",
                           userID: 1,
                           state: 1,
                           milestoneID: "Milestone",
                           createdAt: "20201109",
                           closedAt: "20201110",
                           labels: [label1, label2], assignee: [], milestone: [],
                           comment: IssueComment(comments: [], counts: 5))
        //When
        let viewModel = IssueListViewModel(issue: issue)

        //Then
        XCTAssertEqual(viewModel.isOpen, true)
        XCTAssertEqual(viewModel.milestone.type, .milestone)
        XCTAssertEqual(viewModel.labels.count, 2)

        XCTAssertEqual(viewModel.labels.first?.currentTitleColor, .black)
        XCTAssertEqual(viewModel.labels.last?.currentTitleColor, .white)

        XCTAssertEqual(viewModel.labels.first?.isUserInteractionEnabled, true)
    }

}
