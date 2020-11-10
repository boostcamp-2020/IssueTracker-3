//
//  IssueDetailCollectionViewCell.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/02.
//

import UIKit

class IssueDetailCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var authorImage: UIImageView!

    func configure(of item: IssueDetailViewModel) {
        timeLabel.text = item.createdAt
        descriptionLabel.text = item.body
    }
}
