//
//  CreateIssueViewController.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/02.
//

import UIKit
import MarkdownView

protocol CreateIssueDisplayLogic: class {
  
}

final class CreateIssueViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet private weak var titleLabel: UITextField!
    @IBOutlet private weak var commentTextView: UITextView!
    @IBOutlet private weak var doneLeftBarButton: UIBarButtonItem!
    
    private var markdownPreview: MarkdownView?
    
    // MARK: View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePlaceholder()
        configureMenuItems()
    }
    
    // MARK: Actions
    
    @IBAction func markdownSegmentedControlChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
          // markdown
            return
        case 1:
          // preview
            return
        default:
          return
        }
    }
    
    @IBAction func writingDoneTouched(_ sender: UIBarButtonItem) {
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

// MARK: MarkdownPreview

extension CreateIssueViewController {
    private func configureMarkdownPreview() {
        markdownPreview = MarkdownView()
        
    }
}

// MARK: UITextViewDelegate

extension CreateIssueViewController: UITextViewDelegate {
    private func configurePlaceholder() {
        commentTextView.text = "코멘트는 여기에 작성하세요"
        commentTextView.textColor = UIColor.lightGray
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            configurePlaceholder()
        }
        commentTextView.resignFirstResponder()
    }
}

// MARK: UIMenuItem

extension CreateIssueViewController {
    private func configureMenuItems() {
        let menuController = UIMenuController.shared
        let imagePicker = UIMenuItem(title: "Insert Photo", action: #selector(insertPhotoDidTap))
        menuController.menuItems = [imagePicker]
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
}
