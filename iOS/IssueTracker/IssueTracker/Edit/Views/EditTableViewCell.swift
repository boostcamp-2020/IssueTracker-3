//
//  EditTableViewCell.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/12.
//

import UIKit

class EditTableViewCell: UITableViewCell {
    enum ButtonType {
        case seleted
        case list
    }

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    func configureSeleted(title: String) {
        titleLabel.text = title
    }

    func configureList(title: String) {
        titleLabel.text = title
    }

    func chagneButtonImage(buttonType: ButtonType) {
        switch buttonType {
        case .seleted:
            button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        case .list:
            button.setImage(UIImage(systemName: "minus.circle"), for: .normal)
        }
    }
}
