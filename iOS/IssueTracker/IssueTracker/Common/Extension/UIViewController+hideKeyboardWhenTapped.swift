//
//  UIViewController+hideKeyboard.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/12.
//

import UIKit

extension UIViewController {
    /// TextField 등 editing 상태에서 다른 아무 곳을 tap하면 keyboard를 숨김
    ///```
    /// override func viewDidLoad() {
    ///    super.viewDidLoad()
    ///    hideKeyboardWhenTappedAround()
    /// }
    ///```
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
