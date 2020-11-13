//
//  IssueDetailCollectionViewCell.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/02.
//

import UIKit
import SwiftyMarkdown

class IssueDetailCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!

    func configure(of item: IssueDetailViewModel) {
        timeLabel.text = item.createdAt
        descriptionLabel.attributedText = convertMarkdownText(of: item.body)
        profileImage.image = UIImage()
    }
    
    private func convertMarkdownText(of text: String) -> NSAttributedString {
        let markdown = SwiftyMarkdown(string: text)
        return markdown.attributedString()
    }
}
