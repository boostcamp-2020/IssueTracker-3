//
//  customButtonView.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/03.
//

import UIKit

class CustomButtonView: UIButton {
    private var type: LabelType!
    private var title: String?
    private var color: String!

    enum LabelType {
        case milestone
        case label
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    /// 라벨, 마일스톤 버튼 생성
    /// - Parameters:
    ///   - type: .milestone, .label
    ///   - text: Button Text
    ///   - color: Button Backgroun Color
    convenience init(type: LabelType, text: String?, color: String) {
        self.init(frame: .zero)
        self.type = type
        title = text
        self.color = color
        setting()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setting() {
        self.isHidden = (title == "")
        guard let text = title else {
            return
        }
        let uiColor = UIColor(hex: color)
        
        self.setTitle(text, for: .normal)
        self.setTitleColor(uiColor?.visibleTextColor, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 13)

        switch type {
        case .milestone:
            self.backgroundColor = .white
            self.cornerRadius = 5
            self.borderWidth = 1
            configureContentEdgeInsets(8, 2, 9, 0)
        case .label:
            self.backgroundColor = uiColor
            self.cornerRadius = 3
            configureContentEdgeInsets(7, 2, 7, 2)
        case .none:
            self.backgroundColor = .none
        }

        self.isEnabled = false
    }

    func configureContentEdgeInsets(_ left: CGFloat,
                                    _ top: CGFloat,
                                    _ right: CGFloat,
                                    _ bottom: CGFloat) {
        self.contentEdgeInsets.left = left
        self.contentEdgeInsets.top = top
        self.contentEdgeInsets.right = right
        self.contentEdgeInsets.bottom = bottom
    }
}
