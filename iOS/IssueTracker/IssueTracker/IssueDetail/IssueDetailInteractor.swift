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
        networkService.request(apiConfiguration: IssueDetailEndPoint.getComments(id)) { result in
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
    
    func loadAuthorImage(imageURL: String, with handler: @escaping (Data) -> Void) {
        guard let imageURL = try? imageURL.asURL() else {
            debugPrint("invalid Image URL")
            return
        }
        URLSession.shared.dataTask(with: imageURL) { data, _, error in
            guard error == nil else {
                debugPrint(error)
                return
            }
            guard let data = data else {
                debugPrint("Image data Failure")
                return
            }
            handler(data)
        }.resume()
    }
}
