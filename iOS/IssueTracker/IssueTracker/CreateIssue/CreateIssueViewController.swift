//
//  CreateIssueViewController.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/02.
//

import UIKit

class CreateIssueViewController: UIViewController {
    @IBOutlet private weak var titleLabel: UITextField!
    @IBOutlet private weak var commentTextView: UITextView!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var doneLeftBarButton: UIBarButtonItem!
    
//    private var createIssueManager: CreateIssueManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePlaceholder()
//        createIssueManager = CreateIssueManager()
    }
    
    @IBAction func doneTouched(_ sender: UIBarButtonItem) {
        commentTextView.resignFirstResponder()
    }
    
    @IBAction func uploadIssueTouched(_ sender: Any) {
        // Alert -> 성공 / 실패 시
        
        dismiss(animated: true) { [unowned self] in
            let title = titleLabel.text
            let comment = commentTextView.text
        }
    }

    @IBAction func cancelTouched(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: UITextViewDelegate

extension CreateIssueViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        
        let menuController = UIMenuController.shared
        let imagePicker = UIMenuItem(title: "Insert Photo", action: #selector(insertPhotoDidTap))

        menuController.menuItems = [imagePicker]
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            configurePlaceholder()
        }
        commentTextView.resignFirstResponder()
    }
    
    private func configurePlaceholder() {
        commentTextView.text = "코멘트는 여기에 작성하세요"
        commentTextView.textColor = UIColor.lightGray
    }
}

// MARK: UIMenuItem

extension CreateIssueViewController {
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
}
