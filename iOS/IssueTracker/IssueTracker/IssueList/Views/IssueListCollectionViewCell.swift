//
//  IssueListCollectionViewCell.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/03.
//

import UIKit

final class IssueListCollectionViewCell: UICollectionViewListCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var labelStackView: UIStackView!
    @IBOutlet private weak var issueOpenButton: UIButton!
    @IBOutlet private weak var issueClosedButton: UIButton!
    
    func configure(of item: IssueListViewModel) {
        configureCellLabels(with: item)
        configureLabelStackView(milestone: item.milestone, labels: item.labels)
        configureAccessories()
        configureStateButton(with: item)
    }
    
    private func configureCellLabels(with item: IssueListViewModel) {
        titleLabel.text = item.title
        descriptionLabel.text = item.description
    }

    private func configureLabelStackView(milestone: UIButton, labels: [UIButton]) {
        labelStackView.subviews.forEach({
            $0.removeFromSuperview()
        })

        labelStackView.addArrangedSubview(milestone)
        labels.forEach({
            labelStackView.addArrangedSubview($0)
        })
    }
    
    private func configureStateButton(with item: IssueListViewModel) {
        guard item.isOpen else {
            issueClosedButton.isHidden = false
            issueOpenButton.isHidden = true
            issueOpenButton.alpha = 0
            return
        }
        issueOpenButton.isHidden = false
        issueOpenButton.alpha = 1
        issueClosedButton.isHidden = true
        return
    }
    
    private func configureAccessories() {
        accessories = [.multiselect(displayed: .whenEditing, options: .init())]
        separatorLayoutGuide.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
    }
}
