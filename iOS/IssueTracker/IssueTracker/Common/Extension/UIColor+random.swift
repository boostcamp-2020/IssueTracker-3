//
//  UIColor + hex + random.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/03.
//

import UIKit

extension UIColor {

    /// UIColor 랜덤으로 생성
    ///
    /// - 기존에 있던 UIColor(red:, green:, blue:, alpha:) init 메소드에서 r, g, b에만 random 메소드로 값을 지정
    /// - alpha는 1로 고정
    ///```
    ///let color = UIColor().random()
    ///```
    ///
    /// - Returns: Random UIColor
    func random() -> UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1)
    }
}
