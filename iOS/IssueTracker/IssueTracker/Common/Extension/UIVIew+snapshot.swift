//
//  UIVIew + snapshot.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/03.
//

import UIKit

extension UIView {

    /// View를 UIImage로 생성
    ///
    /// 지정한 view를 이미지로 만들어줌
    /// ```
    /// let uiImage: UIImage = view.snapshot()
    ///
    /// ```
    /// - Returns: UIImage()
    func snapshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, UIScreen.main.scale)
        guard let currentContext = UIGraphicsGetCurrentContext() else { return UIImage() }
        self.layer.render(in: currentContext)
        guard let img = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
        UIGraphicsEndImageContext()
        return img
    }
}
