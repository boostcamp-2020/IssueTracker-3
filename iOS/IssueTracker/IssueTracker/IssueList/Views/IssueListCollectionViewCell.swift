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
    
    func configureIssueListCell(of item: IssueListViewModel) {
        titleLabel.text = item.title
        descriptionLabel.text = item.description
    }
    
    // TODO: Moving Animation
    private func toggleEditingMode() {
        if isInEditingMode {
            contentView.layer.bounds.origin.x -= 40
        } else {
            contentView.layer.bounds.origin.x += 40
        }
    }
  
   override func prepareForReuse() {
        labelStackView.subviews.forEach({
            $0.removeFromSuperview()
        })
    }

    func configureLabelStackView(milestone: String, labels: [String]) {
        let button = CustomButtonView(type: .milestone, text: milestone, color: "#000000")
        labelStackView.addArrangedSubview(button)

        labels.forEach({
            let button = CustomButtonView(type: .label, text: $0, color: "#BEDBFD")
            labelStackView.addArrangedSubview(button)
        })
    }
}
