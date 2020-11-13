//
//  HeaderView.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/02.
//

import UIKit

final class HeaderView: UIView {

    init(label: UILabel) {
        super.init(frame: .zero)
        
        self.addSubview(label)

        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 5),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        ])
    }

    convenience init(text: String) {
        let uiLabel = UILabel().makeLabel(text: text)
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        self.init(label: uiLabel)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension UILabel {
    func makeLabel(text: String) -> UILabel {
        let uiLabel = UILabel()
        uiLabel.text = text
        return uiLabel
    }
}
