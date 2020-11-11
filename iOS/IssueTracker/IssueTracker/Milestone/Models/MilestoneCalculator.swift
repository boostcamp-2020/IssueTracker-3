//
//  MilestoneCalculator.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/11.
//

import Foundation

struct MilestoneCalculator {
    static var openIssuesCounter = [Int: Int]()
    static var closedIssuesCounter = [Int: Int]()
    
    enum IssueState {
        case open
        case closed
    }
    
    static subscript (id: Int, state: IssueState) -> Int {
        switch state {
        case .open:
            return MilestoneCalculator.openIssuesCounter[id] ?? 0
        case .closed:
            return MilestoneCalculator.closedIssuesCounter[id] ?? 0
        }
    }
    
    static func input(milestoneID: MilestoneID, issueState: Int) {
        var key = -1
        switch milestoneID {
        case .integer(let id):
            key = id
        case .string(_:):
            return
        }

        switch issueState {
        case 0:
            MilestoneCalculator.closedIssuesCounter[key, default: 0] += 1
        case 1:
            MilestoneCalculator.openIssuesCounter[key, default: 0] += 1
        default:
            return
        }
    }
    
    static func reset() {
        MilestoneCalculator.openIssuesCounter.removeAll()
        MilestoneCalculator.closedIssuesCounter.removeAll()
    }
    
    static func percentage(of milestoneID: Int) -> Int {
        let openIssuesCount = MilestoneCalculator.openIssuesCounter[milestoneID] ?? 0
        let closedIssuesCount = MilestoneCalculator.closedIssuesCounter[milestoneID] ?? 0
        guard openIssuesCount + closedIssuesCount != 0 else { return 0 }
        return (closedIssuesCount * 100) / (openIssuesCount + closedIssuesCount)
    }
}
