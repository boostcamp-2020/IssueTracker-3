//
//  Interactor.swift
//  IssueTrackerTests
//
//  Created by ParkJaeHyun on 2020/11/13.
//
import XCTest
@testable import IssueTracker

class ListOrdersInteractorTests: XCTestCase {
    // MARK: - Subject under test

    var sut: IssueListInteractor!

    // MARK: - Test lifecycle

    override func setUp() {
        super.setUp()
        setupIssueListInteractor()
    }

    // MARK: - Test setup

    func setupIssueListInteractor() {
        sut = IssueListInteractor()
    }

    // MARK: - Test doubles

    class IssueListPresentationLogicSpy: IssueListPresentationLogic {
        // MARK: Method call expectations

        var presentFetchedListsCalled = false

        // MARK: Spied methods

        func presentFetchedIssues(issues: IssueList) {
            presentFetchedListsCalled = true
        }
    }

    class NetworkServiceSpy: NetworkServiceProvider {
        // MARK: Method call expectations

        var fetchListsCalled = false

        // MARK: Spied methods

        func request(apiConfiguration: APIConfiguration, handler: @escaping (Result<Data, NetworkError>) -> Void) {
            fetchListsCalled = true
            let encoded = [Issue(title: "test", body: "test")].encoded()
            handler(.success(encoded))
        }
    }

    // MARK: - Tests

    func test_Fetch_Lists_Should_Ask_Lists_Presenter_To_Format_Result() {
        // Given
        let issueListPresentationLogicSpy = IssueListPresentationLogicSpy()
        sut.presenter = issueListPresentationLogicSpy

        let networkServiceSpy = NetworkServiceSpy()
        sut.networkService = networkServiceSpy

        // When
        sut.fetchIssues()

        // Then
        XCTAssert(networkServiceSpy.fetchListsCalled, "request에 대한 테스트 실패")
        XCTAssert(issueListPresentationLogicSpy.presentFetchedListsCalled, "fetchIssues() 테스트 실패")
    }
}
