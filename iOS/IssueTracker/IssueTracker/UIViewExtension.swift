//
//  UIViewExtension.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/10/27.
//

import UIKit

extension UIView {
  
  @IBInspectable
  var cornerRadius: CGFloat {
    get { return layer.cornerRadius }
    set { layer.cornerRadius = newValue }
  }
  
  @IBInspectable
  var borderWidth: CGFloat {
    get { return layer.borderWidth }
    set { layer.borderWidth = newValue }
  }
  
  @IBInspectable
  var borderColor: UIColor? {
    get {
      guard let color = layer.borderColor else { return nil }
      return UIColor(cgColor: color)
    }
    set {
      guard let color = newValue else {
        layer.borderColor = nil
        return
      }
      layer.borderColor = color.cgColor
    }
  }
}
