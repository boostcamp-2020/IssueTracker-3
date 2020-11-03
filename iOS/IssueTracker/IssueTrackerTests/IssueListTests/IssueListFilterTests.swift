//
//  IssueListFilterTests.swift
//  IssueTrackerTests
//
//  Created by ParkJaeHyun on 2020/11/03.
//

import XCTest
@testable import IssueTracker

class IssueListFilterTests: XCTestCase {
    func test_filtered_with_IssuesMock_Success() throws {
        // Given
        let issueMock = IssuesMock()
        let filteredIssues = issueMock.issues
        let controller = IssueListModelController()

        // When
        //controller.filtered(with filter: String)
        let filteredIssueListViewModel = controller.filtered(with: "test", model: filteredIssues)

        // Then
        XCTAssertEqual(filteredIssueListViewModel.count, 3)
        XCTAssertTrue(filteredIssueListViewModel.contains(where: { $0.title == "test1"}))
    }
}
