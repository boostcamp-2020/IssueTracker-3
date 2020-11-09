//
//  Data+decoded.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/09.
//

import Foundation

extension Data {
    /// Json Data를 디코딩 해줌
    ///
    /// Generics T : Decodable
    /// ```
    /// guard let decodedData: IssueList = try? data.decoded() else {
    ///     return
    /// }
    ///
    /// guard let decodedData = try? data.decoded() as? IssueList else {
    ///     return
    /// }
    /// ```
    /// - Returns: T
    func decoded<T: Decodable>() throws -> T {
        let decoder = JSONDecoder()
        // decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: self)
    }
}
