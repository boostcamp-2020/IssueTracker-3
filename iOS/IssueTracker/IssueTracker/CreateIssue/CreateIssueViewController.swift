//
//  CreateIssueViewController.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/02.
//

import UIKit

class CreateIssueViewController: UIViewController {
    @IBOutlet private weak var commentWritingTextView: UITextView!
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        configurePlaceholder()
    }

    @IBAction func makeNewIssueButtonTouched(_ sender: Any) {
        dismiss(animated: true) { [unowned self] in
            let title = titleLabel.text
            let comment = commentTextView.text
        }
    }

    @IBAction func cancelButtonTouched(_ sender: Any) {
        dismiss(animated: true)
    }

    func placeholderSetting() {
        commentWritingTextView.delegate = self
        commentWritingTextView.text = "코멘트는 여기에 작성하세요"
        commentWritingTextView.textColor = UIColor.lightGray
    }
}

// MARK: - UIMenuItem
extension CreateIssueViewController {
    override func canPerformAction(_ action: Selector, withSender sender: Any!) -> Bool {
        if action == #selector(insertPhotoDidTap) ||
            action == #selector(cut(_ :)) ||
            action == #selector(copy(_ :)) {
            return true
        }
        return false
    }

    private func configurePlaceholder() {
        commentWritingTextView.text = "코멘트는 여기에 작성하세요"
        commentWritingTextView.textColor = UIColor.lightGray
    }
    
    @objc func insertPhotoDidTap(sender: UIMenuItem) {
        print("image picker")
    }

    @IBAction func cancelTouched(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
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
            configurePlaceholder()
        }
    }
}
