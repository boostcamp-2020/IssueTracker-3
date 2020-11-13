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
    case editMilestone(Data)
    case deleteMilestone(Data)

    var method: HTTPMethod {
        switch self {
        case .getMilestones:
            return .get
        case .addMilestone:
            return .post
        case .editMilestone:
            return .patch
        case .deleteMilestone:
            return .delete
        }
    }

    var path: String {
        switch self {
        case .getMilestones:
            return "/milestone"
        case .addMilestone:
            return "/milestone"
        case .editMilestone:
            return "/milestone"
        case .deleteMilestone:
            return "/milestone"
        }
    }

    var body: Data? {
        switch self {
        case .getMilestones:
            return nil
        case .addMilestone(let data):
            return data
        case .editMilestone(let data):
            return data
        case .deleteMilestone(let data):
            return data
        }
    }
}

