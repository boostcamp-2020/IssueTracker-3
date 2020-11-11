//
//  DateFormatter+format.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/11.
//

import Foundation

extension DateFormatter {
    /// Date를 특정 형식에 맞는 String으로 변환
    ///
    /// 함수를 확장하여 다양하게 사용 가능
    ///
    ///```
    ///let dateToString = DataFormatter(Date())
    ///
    ///```
    ///
    /// - Returns: "YYYY년 M월 d일까지" 형식의 String 타입
    static func format(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.dateFormat = "YYYY년 M월 d일까지"
        return dateFormatter.string(from: date)
    }
}
