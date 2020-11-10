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

// Must
// TODO: markdown preview
// TODO: image link
// TODO: upload logic (데이터 저장 + upload)
// TODO: 밑에 3개 patch logic
// TODO: 밑에 3개 view / vc 구현
// TODO: VIP 구성
// TODO: upload 후 alert or toast
// TODO: 키보드 엔터 -> resign
// TODO: 키보드 -> view 전체 올리기
// TODO: 타이핑 중 아무곳 터치 -> 키보드 내리기

// TODO: 이미지 링크
// TODO: 링크 터치 구현

// Details
// TODO: 글 없어지면 placeholder 다시 뜨게 수정
// TODO: UIMenuController 손 보기
// TODO: refactoring -> 코드 최적화

final class CreateIssueViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var commentTextView: UITextView!
    @IBOutlet private weak var doneLeftBarButton: UIBarButtonItem!
    
    private var markdownPreview: MarkdownView?
    
    // MARK: View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePlaceholder()
        configureMenuItems()
        configureMarkdownPreview()
    }
    
    // MARK: Actions
    
    @IBAction func markdownSegmentedControlChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            concealMarkdownPreview()
        case 1:
            revealMarkdownPreview()
            loadMarkdownPreview()
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
            let title = titleTextField.text
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
        guard let markdownPreview = markdownPreview else { return }
        view.addSubview(markdownPreview)
        markdownPreview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            markdownPreview.topAnchor.constraint(equalTo: commentTextView.topAnchor),
            markdownPreview.bottomAnchor.constraint(equalTo: commentTextView.bottomAnchor),
            markdownPreview.leadingAnchor.constraint(equalTo: commentTextView.leadingAnchor),
            markdownPreview.trailingAnchor.constraint(equalTo: commentTextView.trailingAnchor)
        ])
        concealMarkdownPreview()
    }
    
    private func concealMarkdownPreview() {
        markdownPreview?.isHidden = true
        markdownPreview?.resignFirstResponder()
        commentTextView.isHidden = false
    }
    
    private func revealMarkdownPreview() {
        commentTextView.isHidden = true
        markdownPreview?.isHidden = false
        markdownPreview?.becomeFirstResponder()
    }
    
    private func loadMarkdownPreview() {
        
        markdownPreview?.load(markdown: commentTextView.text)
    }
}

// MARK: UITextFieldDelegate

extension CreateIssueViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        commentTextView.becomeFirstResponder()
        return true
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
