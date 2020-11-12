//
//  IssueDetailInteractor.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/10.
//

import Foundation

protocol IssueDetailDataStore {
    var comments: CommentList { get set }
}

protocol IssueDetailBusinessLogic {
    func fetchComments(id: Int)
}

final class IssueDetailInteractor: IssueDetailDataStore {
    let networkService: NetworkServiceProvider = NetworkService()
    var presenter: IssueDetailPresentationLogic?
    var comments = CommentList()
}

extension IssueDetailInteractor: IssueDetailBusinessLogic {
    func fetchComments(id: Int) {
        networkService.request(apiConfiguration: IssueDetailEndPoint.getComments(id)) {
            [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                debugPrint(error)
                return
            case .success(let data):
                guard let decodedData: CommentList = try? data.decoded() else {
                    debugPrint("decode 실패")
                    return
                }
                self.presenter?.presentFetchedComments(issues: decodedData)
            }
        }
    }
}
