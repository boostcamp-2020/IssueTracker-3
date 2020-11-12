//
//  IssueDetailInteractor.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/10.
//

import Foundation

protocol IssueDetailDataStore {
    var comments: DetailCommentList { get set }
}

protocol IssueDetailBusinessLogic {
    func fetchComments(id: Int)
    func loadAuthorImage(imageURL: String, with handler: @escaping (Data) -> Void)
}

final class IssueDetailInteractor: IssueDetailDataStore {
    let networkService: NetworkServiceProvider = NetworkService()
    var presenter: IssueDetailPresentationLogic?
    var comments = DetailCommentList()
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
                guard let decodedData: DetailCommentList = try? data.decoded() else {
                    debugPrint("decode 실패")
                    return
                }
                self.presenter?.presentFetchedComments(issues: decodedData)
            }
        }
    }
    
    func loadAuthorImage(imageURL: String = "https://user-images.githubusercontent.com/5876149/97951341-39d26600-1ddd-11eb-94e7-9102b90bda8b.jpg", with handler: @escaping (Data) -> Void) {
        guard let imageURL = try? imageURL.asURL() else {
            debugPrint("invalid Image URL")
            return
        }
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: imageURL) else {
                debugPrint("Image URL Not Available")
                return
            }
            handler(data)
        }
    }
}
