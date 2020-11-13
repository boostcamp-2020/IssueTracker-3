//
//  Date+.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/13.
//

import Foundation

extension Date {
    /// Date를 특정 형식에 맞는 String으로 변환
    ///
    /// 함수를 확장하여 다양하게 사용 가능
    ///
    /// - Returns: String
    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        formatter.dateTimeStyle = .numeric
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
