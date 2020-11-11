//
//  MilestoneEndPoint.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/11.
//

import Foundation

enum MilestoneEndPoint: APIConfiguration {
    case getMilestones
    case addMilestone(Data)

    var method: HTTPMethod {
        switch self {
        case .getMilestones:
            return .get
        case .addMilestone:
            return .post
        }
    }

    var path: String {
        switch self {
        case .getMilestones:
            return "/milestone"
        case .addMilestone:
            return "/milestone"
        }
    }

    var body: Data? {
        switch self {
        case .getMilestones:
            return nil
        case .addMilestone(let data):
            return data
        }
    }
}
