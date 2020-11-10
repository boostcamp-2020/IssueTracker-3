//
//  IssueDetailViewModel.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/09.
//

import Foundation

class IssueDetailViewModel: Hashable {
    let id: Int
    let body: String
    let emoji: String
    let issueID: Int
    var createdAt: String
    let identifier = UUID()

    init(id: Int,
         body: String,
         emoji: String,
         issueID: Int,
         createdAt: String) {
        self.id = id
        self.body = body
        self.emoji = emoji
        self.issueID = issueID
        self.createdAt = createdAt
    }

    init(commentList: Comment) {
        self.id = commentList.id
        self.body = commentList.body
        self.emoji = commentList.emoji
        self.issueID = commentList.issueID ?? 0
        self.createdAt = commentList.createdAt
        self.setAgoTime(commentList.createdAt)
    }

    func setAgoTime(_ time: String) {
        guard let time = time.toDate()?.timeAgoDisplay() else { return }
        self.createdAt = time
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    static func == (lhs: IssueDetailViewModel, rhs: IssueDetailViewModel) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

extension Date {
    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        formatter.dateTimeStyle = .numeric

        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
