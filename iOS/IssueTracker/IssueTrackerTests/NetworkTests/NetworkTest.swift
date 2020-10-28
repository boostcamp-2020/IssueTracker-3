//
//  NetworkTest.swift
//  IssueTrackerTests
//
//  Created by ParkJaeHyun on 2020/10/28.
//
import XCTest
@testable import Alamofire
@testable import IssueTracker

struct User: Codable {
    let userID: String
    let password: String
}

final class NetworkManagerStub: SessionManager {
    var requestParameters: (
        url: URLConvertible,
        method: HTTPMethod
    )?

    func request(_ convertible: URLConvertible,
                 method: HTTPMethod,
                 parameters: Parameters?,
                 encoding: ParameterEncoding,
                 headers: HTTPHeaders?,
                 interceptor: RequestInterceptor?,
                 requestModifier: Session.RequestModifier?) -> DataRequest {
        self.requestParameters = (
            url: convertible,
            method: method
        )

        let url = URL(string: "aaa")

        return .init(convertible: URLRequest(url: url!),
                     underlyingQueue: DispatchQueue(label: ""),
                     serializationQueue: DispatchQueue(label: ""),
                     eventMonitor: nil,
                     interceptor: nil,
                     delegate: Session()
        )
    }
}

final class NetworkTest: XCTestCase {

    func testNetwork_get() throws {
        //given
        let networkManagerStub = NetworkManagerStub()
        let network = NetworkManager(sessionManager: networkManagerStub)

        //when
        network.request(url: "http://api.boostcamp.com/auth/login", completionHandler: { _ in
//            UIStoryboard.init(name: "", bundle: <#T##Bundle?#>)
        })

        //then
        XCTAssertEqual(try? networkManagerStub.requestParameters?.url.asURL(),
                       URL(string: "http://api.boostcamp.com/auth/login"))
        XCTAssertEqual(networkManagerStub.requestParameters?.method, .get)
    }
}
