//
//  String + toDate.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/04.
//

import Foundation

extension String {
    /// Date 타입으로 변경
    ///
    ///```
    ///let str = "2020-11-01T15:00:00.000Z"
    ///str.toDate()
    ///```
    ///
    /// - Returns: "yyyy-MM-dd'T'HH:mm:ss.SSSZ" 형식의 Date 타입
  func toDate() -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    //"yyyy-MM-dd'T'HH:mm:ssZ"
    let date: Date? = dateFormatter.date(from: self)
    return date
  }
}
