//
//  IssueListMakeTests.swift
//  IssueTrackerTests
//
//  Created by ParkJaeHyun on 2020/11/03.
//

import XCTest
@testable import IssueTracker

class IssueListMakeTests: XCTestCase {
    func testExample() throws {
        // Given
        let issueMock = IssuesMock()
        let makedIssues = issueMock.issues
        let controller = IssueListModelController()

        let originCount = makedIssues.count

        let addModel = IssueListViewModel(
            title: "haha",
            description: "설명",
            milestone: CustomButtonView(type: .milestone,
                                        text: "프로젝트",
                                        color: "#ffffff"),
            labels: [CustomButtonView(type: .label,
                                      text: "label",
                                      color: "#ffffff"),
                     CustomButtonView(type: .label,
                                      text: "labe",
                                      color: "#ffffff")])

        // When
        let makedIssueListViewModel = controller.add(model: addModel, to: makedIssues)

        // Then
        XCTAssertEqual(makedIssueListViewModel.count, originCount + 1)
    }
}
