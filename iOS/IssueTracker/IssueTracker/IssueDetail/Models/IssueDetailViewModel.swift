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
    var createdAt: String
    let img: String
    let identifier = UUID()

    init(id: Int,
         body: String,
         emoji: String,
         createdAt: String,
         img: String) {
        self.id = id
        self.body = body
        self.emoji = emoji
        self.createdAt = createdAt
        self.img = img
    }

    init(commentList: DetailComment) {
        self.id = commentList.id
        self.body = commentList.body
        self.emoji = commentList.emoji
        self.createdAt = commentList.createdAt
        self.img = commentList.img
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
