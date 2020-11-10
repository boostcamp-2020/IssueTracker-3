//
//  UIColor+hexString.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/09.
//

import UIKit

extension UIColor {
    /// UIColor를 hexString으로 변경
    /// 
    ///```
    ///let color = UIColor.red
    ///let hex = color.hexString // "#FF2600"
    ///```
    var hexString: String {
        let components = self.cgColor.components
        let red: CGFloat = components?[0] ?? 0.0
        let green: CGFloat = components?[1] ?? 0.0
        let blue: CGFloat = components?[2] ?? 0.0
        return String(
            format: "#%02lX%02lX%02lX",
            lroundf(Float(red * 255)),
            lroundf(Float(green * 255)),
            lroundf(Float(blue * 255))
        )
    }
}
