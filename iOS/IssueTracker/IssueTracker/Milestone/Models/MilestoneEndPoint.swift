//
//  MilestoneEndPoint.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/11.
//

import Foundation

enum MilestoneEndPoint: APIConfiguration {
    case getMilestones

    var method: HTTPMethod {
        switch self {
        case .getMilestones:
            return .get
        }
    }

    var path: String {
        switch self {
        case .getMilestones:
            return "/milestone"
        }
    }

    var body: Data? {
        switch self {
        case .getMilestones:
            return nil
        }
    }
}
