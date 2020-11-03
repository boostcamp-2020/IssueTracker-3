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
    @IBOutlet weak var mileStone: UIButton!
    @IBOutlet weak var firstLabel: UIButton!
    @IBOutlet weak var secondLabel: UIButton!
    
    func configureIssueListCell(of item: IssueListViewModel) {
        titleLabel.text = item.title
        issueListDescription.text = item.description
        firstLabel.titleLabel?.text = item.labels.first
        secondLabel.titleLabel?.text = item.labels.last
        mileStone.titleLabel?.text = item.milestone
    }
}
