//
//  CreateIssueViewController.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/02.
//

import UIKit

class CreateIssueViewController: UIViewController {
    @IBOutlet private weak var commentWritingTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placeholderSetting()
    }

    override func canPerformAction(_ action: Selector, withSender sender: Any!) -> Bool {
        if action == #selector(insertPhotoDidTap) ||
            action == #selector(cut(_ :)) ||
            action == #selector(copy(_ :)) {
            return true
        }
        return false
    }

    @objc func insertPhotoDidTap(sender: UIMenuItem) {
        print("image picker")
    }

    func placeholderSetting() {
        commentWritingTextView.delegate = self
        commentWritingTextView.text = "코멘트는 여기에 작성하세요"
        commentWritingTextView.textColor = UIColor.lightGray
    }
}

extension CreateIssueViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        
        let uiMenuController = UIMenuController.shared
        let imagePicker = UIMenuItem(title: "Insert Photo", action: #selector(insertPhotoDidTap))

        uiMenuController.menuItems = [imagePicker]
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "코멘트는 여기에 작성하세요"
            textView.textColor = UIColor.lightGray
        }
    }
}