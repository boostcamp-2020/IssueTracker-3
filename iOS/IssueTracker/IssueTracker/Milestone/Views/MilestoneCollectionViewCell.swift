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
       
    }
}
