//
//  NetworkTest.swift
//  IssueTrackerTests
//
//  Created by ParkJaeHyun on 2020/10/28.
//
import XCTest
@testable import Alamofire
@testable import IssueTracker

struct ToDoModel: Codable {
    let park: String
    let song: String
}

final class NetworkManagerTest: XCTestCase {
    func test_request_with_endPointMock_success() throws {
        //Given
        let endPointMock = EndPointMock()
        let sessionManagerStub = SessionManagerStub()
        let network = NetworkManager(sessionManager: sessionManagerStub)

        //When
        network.request(endPoint: endPointMock) { _ in }

        //Then
        let userData = sessionManagerStub.userData

        XCTAssertEqual(
            userData?.method,
            .get
        )

        XCTAssertEqual(
            try userData?.path?.asURL().absoluteString,
            "http://api.boostcamp.com/test"
        )

        guard let data = userData?.body else {
            XCTFail("fail")
            return
        }

        let model = try? JSONDecoder().decode(ToDoModel.self, from: data)

        XCTAssertEqual(
            model?.park,
            "jaehyun"
        )

        XCTAssertEqual(
            model?.song,
            "minkwan"
        )
    }
}
