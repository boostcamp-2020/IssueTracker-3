//
//  MilestoneInterator.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/11.
//

import Foundation

protocol MilestoneDataStore {
    var milestones: MilestoneList { get set }
}

protocol MilestoneBusinessLogic {
    func fetchMilestones()
}

final class MilestoneInteractor: MilestoneDataStore {
    let networkService: NetworkServiceProvider = NetworkService()
    var presenter: MilestonePresentationLogic?
    var milestones = MilestoneList()
}

extension MilestoneInteractor: MilestoneBusinessLogic {
    func fetchMilestones() {
        networkService.request(apiConfiguration: MilestoneEndPoint.getMilestones) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                debugPrint(error)
                return
            case .success(let data):
                guard let decodedData: MilestoneList = try? data.decoded() else {
                    debugPrint("decode 실패")
                    return
                }
                self.milestones = decodedData
                self.presenter?.presentFetchedMilestones(milestones: self.milestones)
            }
        }
    }
}
