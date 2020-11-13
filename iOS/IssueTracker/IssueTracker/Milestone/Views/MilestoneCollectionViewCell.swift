//
//  MilestoneCollectionViewCell.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/11.
//

import UIKit

class MilestoneCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var milestoneStackView: UIStackView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var dueDateLabel: UILabel!
    @IBOutlet private weak var percentageLabel: UILabel!
    @IBOutlet private weak var openIssuesCountLabel: UILabel!
    @IBOutlet private weak var closedIssuesCountLabel: UILabel!
    
    func configure(viewModel: MilestoneViewModel) {
        milestoneStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        milestoneStackView.addArrangedSubview(viewModel.milestoneButton)
        descriptionLabel.text = viewModel.description
        dueDateLabel.text = convertDueDateFormat(of: viewModel.dueDate)
        percentageLabel.text = viewModel.percentage
        openIssuesCountLabel.text = viewModel.openIssuesCount
        closedIssuesCountLabel.text = viewModel.closedIssuesCount
    }
    
    private func convertDueDateFormat(of dueDate: String) -> String {
        guard let dueDate = dueDate.toDate() else {
            return ""
        }
        return DateFormatter.format(dueDate)
    }
}
