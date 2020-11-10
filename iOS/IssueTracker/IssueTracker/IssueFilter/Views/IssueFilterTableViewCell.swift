//
//  IssueFilterTableViewCell.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/02.
//

import UIKit

enum ChevronDirection {
    case down
    case check
    case right

    func setImage() -> UIImage? {
        switch self {
        case .down:
            return UIImage(systemName: "chevron.down")
        case .check:
            return UIImage(systemName: "checkmark")
        case .right:
            return UIImage(systemName: "chevron.right")
        }
    }
}

class IssueFilterTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var down: UIButton!
    @IBOutlet weak var check: UIButton!
    @IBOutlet weak var right: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func prepareForReuse() {
        
    }

    override func updateConfiguration(using state: UICellConfigurationState) {
        var back = UIBackgroundConfiguration.listPlainCell().updated(for: state)
    
        if state.isSelected {
            back.backgroundColor = .systemYellow
        }

        self.backgroundConfiguration = back
    }

    func changeButton(kind: ChevronDirection) {
        switch kind {
        case .down:
            down.isHidden = false
            check.isHidden = true
            right.isHidden = true
        case .check:
            down.isHidden = true
            check.isHidden = false
            right.isHidden = true
        case .right:
            down.isHidden = true
            check.isHidden = true
            right.isHidden = false
        }
    }

    func configure(withViewModel viewModel: IssueFilterViewModel) {
        titleLabel.text = "\(viewModel.title)"
        
        if viewModel.childItem.isEmpty {
            check.isHidden = viewModel.isChevron
            right.isHidden = true
            down.isHidden = true
        } else {
            right.isHidden = viewModel.isChevron
            down.isHidden = !viewModel.isChevron
            check.isHidden = true
        }
    }
}
