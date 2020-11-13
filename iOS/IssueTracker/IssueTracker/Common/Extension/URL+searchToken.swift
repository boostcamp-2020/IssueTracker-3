//
//  URL+searchToken.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/11.
//

import Foundation

extension URL {
    /// URL에서 tokenQuery에 해당하는 token을 찾아줌
    ///
    /// ```
    /// callBackURL.searchToken(of: self.tokenQuery)
    ///
    /// ```
    ///
    /// - Returns: String
    func searchToken(of tokenQuery: String) -> String {
        guard let queryItems = URLComponents(string: self.absoluteString)?.queryItems,
              let token = queryItems.first(where: { $0.name == tokenQuery })?.value
        else {
            return ""
        }
        return token
    }
}
