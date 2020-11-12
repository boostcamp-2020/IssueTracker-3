//
//  EditInteractor.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/12.
//

import Foundation

protocol EditDataStore {
    var comments: DetailCommentList { get set }
}

protocol EditBusinessLogic {
    func fetchAllGetUser()
    func fetchAllGetLabel()
    func fetchAllGetMilestone()
}

final class EditInteractor: EditDataStore {
    let networkService: NetworkServiceProvider = NetworkService()
    var presenter: EditPresentationLogic?
    var comments = DetailCommentList()
}

extension EditInteractor: EditBusinessLogic {
    func fetchAllGetUser() {
        networkService.request(apiConfiguration: IssueDetailEditEndPoint.getAllUser) { result in
            switch result {
            case .failure(let error):
                debugPrint(error)
                return
            case .success(let data):
                guard let decodedData: AllGetUserList = try? data.decoded() else {
                    debugPrint("decode 실패")
                    return
                }
                self.presenter?.presentFetchAllGetUser(issues: decodedData)
            }
        }
    }
    func fetchAllGetLabel() {
        networkService.request(apiConfiguration: LabelEndPoint.getLebels) { result in
            switch result {
            case .failure(let error):
                debugPrint(error)
                return
            case .success(let data):
                guard let decodedData: LabelList = try? data.decoded() else {
                    debugPrint("decode 실패")
                    return
                }
                self.presenter?.presentFetchAllGetLabel(issues: decodedData)
            }
        }
    }
    func fetchAllGetMilestone() {
        networkService.request(apiConfiguration: MilestoneEndPoint.getMilestones) { result in
            switch result {
            case .failure(let error):
                debugPrint(error)
                return
            case .success(let data):
                guard let decodedData: MilestoneList = try? data.decoded() else {
                    debugPrint("decode 실패")
                    return
                }
                self.presenter?.presentFetchAllGetMilestone(issues: decodedData)
            }
        }
    }
}
