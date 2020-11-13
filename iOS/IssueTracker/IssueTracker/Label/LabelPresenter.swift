//
//  LabelPresenter.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/10.
//

import Foundation

protocol LabelPresentationLogic {
    func presentFetchedLabels(labels: LabelList)
}

class LabelPresenter: LabelPresentationLogic {
    weak var viewController: LabelDisplayLogic?

    func presentFetchedLabels(labels: LabelList) {
        DispatchQueue.main.async { [weak self] in
            let viewModel = labels.map { LabelViewModel(label: $0) }
            self?.viewController?.displayFetchedLabels(viewModel: viewModel)}
    }
}
