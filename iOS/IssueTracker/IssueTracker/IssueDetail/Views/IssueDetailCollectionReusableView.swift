//
//  IssueDetailCollectionReusableView.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/10.
//
import UIKit

// 1
class IssueDetailCollectionReusableView: UICollectionReusableView {
    static let identifier = "IssueDetailCollectionReusableView"

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var stateButton: UIButton!
    @IBOutlet weak var issueNumberLabel: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configure(item: IssueListViewModel) {
        authorLabel.text = item.title
        issueNumberLabel.text = "#\(item.id)"
        bodyLabel.text = item.description
        if item.isOpen {
            stateButton.titleLabel?.text = "Open"
            stateButton.backgroundColor = .systemGreen
            stateButton.titleLabel?.textColor = .black
        } else {
            stateButton.titleLabel?.text = "Close"
            stateButton.backgroundColor = .systemRed
            stateButton.titleLabel?.textColor = .black
        }
    }
}
