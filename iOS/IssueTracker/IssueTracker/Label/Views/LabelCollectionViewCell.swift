//
//  LabelCollectionViewCell.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/10.
//

import UIKit

class LabelCollectionViewCell: UICollectionViewListCell {
    @IBOutlet weak var labelStackView: UIStackView!
    @IBOutlet weak var descriptionLabel: UILabel!

    func configure(viewModel: LabelViewModel) {
        labelStackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        labelStackView.addArrangedSubview(viewModel.labelButton)
        descriptionLabel.text = viewModel.description
    }
}
