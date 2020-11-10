//
//  LabelEndPoint.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/10.
//

import Foundation

enum LabelEndPoint: APIConfiguration {
    case getLebels

    var method: HTTPMethod {
        switch self {
        case .getLebels:
            return .get
        }
    }

    var path: String {
        switch self {
        case .getLebels:
            return "/label"
        }
    }

    var body: Data? {
        switch self {
        case .getLebels:
            return nil
        }
    }
}
