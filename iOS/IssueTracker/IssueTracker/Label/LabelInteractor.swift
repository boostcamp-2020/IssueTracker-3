//
//  LabelInteractor.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/10.
//

import Foundation

protocol LabelBusinessLogic {
    func fetchLabels()
}

protocol LabelDataStore {
    var labels: LabelList { get set }
}

class LabelInteractor: LabelBusinessLogic, LabelDataStore {
    var labels = LabelList()
    
    let networkService: NetworkServiceProvider = NetworkService()
    var presenter: LabelPresentationLogic?

    func fetchLabels() {
        networkService.request(apiConfiguration: LabelEndPoint.getLebels) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(_):
                print("실패 ")
                return
            case .success(let data):
                guard let decodedData: LabelList = try? data.decoded() else {
                    print("decode 실패")
                    return
                }
                self.labels = decodedData
                self.presenter?.presentFetchedLabels(labels: self.labels)
            }
        }
    }
}
