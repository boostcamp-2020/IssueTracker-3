//
//  SectionHeaderReusableView.swift
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
}
