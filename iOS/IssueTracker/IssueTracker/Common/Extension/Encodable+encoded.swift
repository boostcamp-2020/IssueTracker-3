//
//  Encodable+encoded.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/10.
//

import Foundation

extension Encodable {
    /// Encodable 객체를 인코딩 해줌
    ///
    /// ```
    /// guard let data = try? data.encoded() else {
    ///     return
    /// }
    /// ```
    ///
    /// - Returns: Data
    func encoded() -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.keyEncodingStrategy = .convertToSnakeCase
        guard let encodedData = try? encoder.encode(self) else { return Data() }
        return encodedData
    }
}
