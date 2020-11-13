//
//  MilestonePresenter.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/11.
//

import Foundation

protocol MilestonePresentationLogic {
    func presentFetchedMilestones(milestones: MilestoneList)
}

final class MilestonePresenter: MilestonePresentationLogic {
    weak var viewController: MilestoneDisplayLogic?
    
    func presentFetchedMilestones(milestones: MilestoneList) {
        DispatchQueue.main.async { [weak self] in
            let viewModel = milestones.map { MilestoneViewModel(milestone: $0) }
            self?.viewController?.displayFetchedMilestones(viewModel: viewModel)
        }
    }
}
