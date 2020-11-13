//
//  APIConfiguration.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/10/28.
//

import Foundation

protocol APIConfiguration {
    var method: HTTPMethod { get }
    var path: String { get }
    var body: Data? { get }
}
