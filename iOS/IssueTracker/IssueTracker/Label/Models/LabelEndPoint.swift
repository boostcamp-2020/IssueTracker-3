//
//  LabelEndPoint.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/10.
//

import Foundation

enum LabelEndPoint: APIConfiguration {
    case getLebels
    case addLabel(Data)
    case editLabel(Data)

    var method: HTTPMethod {
        switch self {
        case .getLebels:
            return .get
        case .addLabel:
            return .post
        case .editLabel:
            return .patch
        }
    }

    var path: String {
        switch self {
        case .getLebels:
            return "/label"
        case .addLabel:
            return "/label"
        case .editLabel:
            return "/label"
        }
    }

    var body: Data? {
        switch self {
        case .getLebels:
            return nil
        case .addLabel(let data):
            return data
        case .editLabel(let data):
            return data
        }
    }
}
