//
//  NetworkTest.swift
//  IssueTrackerTests
//
//  Created by ParkJaeHyun on 2020/10/28.
//

import XCTest
@testable import IssueTracker

final class IssueListEndPointTest: XCTestCase {

    class NetworkServiceMock: NetworkServiceProvider {
        var token: String = ""
        var request: (
            method: HTTPMethod,
            path: String,
            body: Data?
        )?

        func request(apiConfiguration: APIConfiguration, handler: @escaping (Result<Data, NetworkError>) -> Void) {
            self.request = (
                method: apiConfiguration.method,
                path: apiConfiguration.path,
                body: apiConfiguration.body
            )

            handler(.success(Data()))
        }
    }

    func test_issueListEndPoint() throws {
        //Given
        let networkService = NetworkServiceMock()

        //When
        networkService.request(apiConfiguration: IssueListEndPoint.getIssues) {_ in 
            
        }

        //Then
        let request = networkService.request
        XCTAssertNil(request?.body)
        XCTAssertEqual(request?.method, .get)
        XCTAssertEqual(request?.path, "/issue")
    }

    func test_request_with_issueListEndPoint_success() throws {
        //Given
        let expectation = XCTestExpectation(description: "NetworkTaskExpectation")
        let networkService = NetworkService()
        let getIssues = IssueListEndPoint.getIssues

        //When
        networkService.request(apiConfiguration: getIssues) { result in
            //Then
            switch result {
            case .success(let data):
                guard let data: IssueList = try? data.decoded() else {
                    XCTFail("Throw 에러")
                    return
                }
                XCTAssertNotNil(data, "네트워크 연결 실패")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("네트워크 연결 실패\(error)")
            }

        }
        wait(for: [expectation], timeout: 5.0)
    }
}
