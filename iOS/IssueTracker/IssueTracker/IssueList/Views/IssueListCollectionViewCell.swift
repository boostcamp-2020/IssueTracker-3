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
    @IBOutlet weak var labelStackView: UIStackView!
    
    var isInEditingMode: Bool = false {
        didSet {
            toggleEditingMode()
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isInEditingMode {
                backgroundColor = .systemGray4
            }
        }
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//
//        labelStackView.subviews.forEach({
//            $0.removeFromSuperview()
//        })
//    }

    fileprivate func extractedFunc(_ item: IssueListViewModel) {
        titleLabel.text = item.title
        descriptionLabel.text = item.description
    }
    
    func configureIssueListCell(of item: IssueListViewModel) {
        extractedFunc(item)
        
        configureLabelStackView(milestone: item.milestone, labels: item.labels)
    }
    
    func configureLabelStackView(milestone: UIButton, labels: [UIButton]) {
        labelStackView.subviews.forEach({
            $0.removeFromSuperview()
        })

        labelStackView.addArrangedSubview(milestone)
        labels.forEach({
            labelStackView.addArrangedSubview($0)
        })
    }
    
    // TODO: Moving Animation
    private func toggleEditingMode() {
        if isInEditingMode {
            contentView.layer.bounds.origin.x -= 40
        } else {
            contentView.layer.bounds.origin.x += 40
        }
    }
}
