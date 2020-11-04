//
//  IssueListCollectionViewCell.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/03.
//

import UIKit

class IssueListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var issueListDescription: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var labelStackView: UIStackView!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
