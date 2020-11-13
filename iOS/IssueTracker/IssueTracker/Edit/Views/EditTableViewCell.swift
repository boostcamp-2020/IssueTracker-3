//
//  EditTableViewCell.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/12.
//

import UIKit

final class EditTableViewCell: UITableViewCell {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    
    enum ButtonType {
        case seleted
        case list
    }

    func configure(button: CustomButtonView) {
        stackView.addArrangedSubview(button)
    }

    func changeButtonImage(buttonType: ButtonType) {
        switch buttonType {
        case .seleted:
            button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        case .list:
            button.setImage(UIImage(systemName: "minus.circle"), for: .normal)
        }
    }
}
