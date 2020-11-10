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
    
    var isInEditingMode: Bool = false { didSet { } } // selected 문제 해결 후 삭제 예정
    
    func configure(of item: IssueListViewModel) {
        configureCellLabels(with: item)
        configureLabelStackView(milestone: item.milestone, labels: item.labels)
        configureAccessories()
    }
    
    private func configureCellLabels(with item: IssueListViewModel) {
        titleLabel.text = item.title
        descriptionLabel.text = item.description
    }
    
    // TODO: milestone, labels가 nil 이라면?
    private func configureLabelStackView(milestone: UIButton, labels: [UIButton]) {
        labelStackView.subviews.forEach({
            $0.removeFromSuperview()
        })

        labelStackView.addArrangedSubview(milestone)
        labels.forEach({
            labelStackView.addArrangedSubview($0)
        })
    }
    
    private func configureAccessories() {
        accessories = [.multiselect(displayed: .whenEditing, options: .init())]
        separatorLayoutGuide.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
    }
}
