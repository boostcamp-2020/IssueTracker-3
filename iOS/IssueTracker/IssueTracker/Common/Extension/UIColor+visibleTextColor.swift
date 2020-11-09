//
//  UIColor+visibleTextColor.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/09.
//

import UIKit

extension UIColor {
    /// 배경색 기준으로 Text Color (black & white) 정해줌
    ///```
    ///let uiColor = UIColor.black
    ///let textColor = uiColor.visibleTextColor // "UIColor.white"
    ///```
    var visibleTextColor: UIColor {
        let ciColor = CIColor(color: self)
        let red = ciColor.red
        let green = ciColor.green
        let blue = ciColor.blue
        let yiq = ((red * 299) + (green * 587) + (blue * 114))/1000
        return yiq >= 128/255 ? UIColor.black : UIColor.white
    }
}
