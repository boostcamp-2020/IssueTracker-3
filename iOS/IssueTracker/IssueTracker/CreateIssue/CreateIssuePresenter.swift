//
//  CreateIssuePresenter.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/10.
//

import Foundation

protocol CreateIssuePresentationLogic {
    
}

final class CreateIssuePresenter: CreateIssuePresentationLogic {
    weak var viewController: CreateIssueDisplayLogic?

    func presentFetchedIssues(issues: IssueList) {
        
    }
    
    // upload 성공 실패 여부 안내
}
