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

    var method: HTTPMethod {
        switch self {
        case .getLebels:
            return .get
        case .addLabel:
            return .post
        }
    }

    var path: String {
        switch self {
        case .getLebels:
            return "/label"
        case .addLabel:
            return "/label"
        }
    }

    var body: Data? {
        switch self {
        case .getLebels:
            return nil
        case .addLabel(let data):
            return data
        }
    }
}
