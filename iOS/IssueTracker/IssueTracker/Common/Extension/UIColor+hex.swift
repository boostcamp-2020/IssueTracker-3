//
//  UIColor+hex.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/04.
//

import UIKit

extension UIColor {
    /// hex값으로 UIColor으로 초기화
    ///
    /// hex값을 입력하면 해당하는 색을 UIColor로 생성해준다.
    /// ```
    /// let color = UIColor(hex: "#000000")
    ///
    /// ```
    /// - Parameter hex: alpha값을 제외한 hex값
    convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = 1.0

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}
