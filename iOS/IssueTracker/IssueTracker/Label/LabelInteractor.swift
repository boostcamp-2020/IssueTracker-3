//
//  LabelInteractor.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/10.
//

import Foundation

protocol LabelDataStore {
    var labels: LabelList { get set }
}

protocol LabelBusinessLogic {
    func fetchLabels()
}

final class LabelInteractor: LabelDataStore {
    let networkService: NetworkServiceProvider = NetworkService()
    var presenter: LabelPresentationLogic?
    var labels = LabelList()
}

extension LabelInteractor: LabelBusinessLogic {
    func fetchLabels() {
        networkService.request(apiConfiguration: LabelEndPoint.getLebels) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                debugPrint(error)
                return
            case .success(let data):
                guard let decodedData: LabelList = try? data.decoded() else {
                    debugPrint("decode 실패")
                    return
                }
                self.labels = decodedData
                self.presenter?.presentFetchedLabels(labels: self.labels)
            }
        }
    }
}
