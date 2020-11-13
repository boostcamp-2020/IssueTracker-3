//
//  String+asURL.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/10.
//

import Foundation

extension String {
    /// String 타입 url을 URL타입으로 변환
    ///```
    ///let url = "http://asURL.com"
    ///let urlType = url.asURL // URL타입으로 반환
    ///```
    /// - Throws: NetworkError.invalidURL
    /// - Returns: URL타입
    func asURL() throws ->  URL {
        guard let url = URL(string: self) else { throw NetworkError.invalidURL }

        return url
    }
}
