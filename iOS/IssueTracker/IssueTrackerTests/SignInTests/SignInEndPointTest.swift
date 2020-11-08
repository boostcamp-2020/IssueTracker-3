//
//  SignInEndPointTest.swift
//  IssueTrackerTests
//
//  Created by ParkJaeHyun on 2020/10/28.
//

import XCTest
@testable import IssueTracker

class SignInEndPointTest: XCTestCase {
    func test_asURLRequest_with_userMock_success() {
        //Given
        let userMock = User(userID: "test", password: "1234")
        let signInEndPoint = SignInEndPoint.user(userMock)

        //When
        let urlRequest = try? signInEndPoint.asURLRequest()

        //Then
        XCTAssertEqual(try urlRequest?.url?.asURL().absoluteString, "http://101.101.210.34:3000/auth/login")
        XCTAssertEqual(urlRequest?.method, .get)

        guard let data = urlRequest?.httpBody else {
            XCTFail("fail")
            return
        }

        let model = try? JSONDecoder().decode(User.self, from: data)

        XCTAssertEqual(model?.userID, userMock.userID)
        XCTAssertEqual(model?.password, userMock.password)
    }
}
