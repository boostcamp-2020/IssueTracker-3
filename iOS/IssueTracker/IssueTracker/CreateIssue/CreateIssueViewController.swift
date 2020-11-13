//
//  CreateIssueViewController.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/02.
//

import UIKit
import Combine
import MarkdownView

// Must
// TODO: image link
// TODO: upload logic (데이터 저장 + upload)
// TODO: 밑에 3개 patch logic
// TODO: 밑에 3개 view / vc 구현
// TODO: VIP 구성
// TODO: upload 후 alert or toast

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
    @IBOutlet private weak var doneRightBarButton: UIBarButtonItem!
    @IBOutlet private weak var separatorView: UIView!
    @IBOutlet private weak var commentTextViewBottomConstraint: NSLayoutConstraint!
    
    private var interactor: CreateIssueBusinessLogic!
    private var markdownPreview: MarkdownView?
    private var keyboardShowObserver: AnyCancellable?
    private var keyboardHideObserver: AnyCancellable?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var assigneeStackView: UIStackView!
    @IBOutlet weak var labelStackView: UIStackView!
    @IBOutlet weak var milestoneStackView: UIStackView!
    
    var isEdit: Bool = false
    var issueNumber: Int?
    var titleText: String?
    var body: String?
    var labels: [CustomButtonView]?
    var milestone: CustomButtonView?

    private var publisher: AnyCancellable!

    // MARK: View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configurePlaceholder()
        configureMenuItems()
        hideKeyboardWhenTappedAround()
        configureObservers()
        configureNotification()
        toggleRightBarButtonItem(isEnable: false)

        labels?.forEach({
            labelStackView.addArrangedSubview($0)
        })

        guard let milestone = milestone else { return }
        milestoneStackView.addArrangedSubview(milestone)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isEdit {
            titleLabel.text = "#\(issueNumber ?? 0)"
            titleLabel.font = UIFont(name: "title", size: .init(10))
            titleTextField.text = titleText
            commentTextView.text = body
            commentTextView.textColor = UIColor.black
        }
    }

    // MARK: Setup
    
    private func setup() {
        interactor = CreateIssueInteractor()
    }
    
    // MARK: Configure

    var assigneeIDs = [Int?]()
    var labelIDs = [Int?]()
    var milestoneIDs = [Int]()

    private func configureNotification() {
        publisher = NotificationCenter.default
            .publisher(for: Notification.Name(rawValue: "EditViewController"))
            .sink { [weak self] selectedItem in
                guard let self = self,
                      let selected = selectedItem.userInfo?["selected"] as? [IssueDetailEditViewModel],
                      let type = selectedItem.userInfo?["type"] as? EditViewController.EditType else { return }

                switch type {
                case .assignee:
                    selected.forEach({
                        if let assignee = $0.assignee {
                            self.assigneeStackView.addArrangedSubview(assignee)
                            self.assigneeIDs.append($0.assigneeID)
                        }
                    })
                case .label:
                    selected.forEach({
                        if let labels = $0.labels {
                            self.labelStackView.addArrangedSubview(labels)
                            self.labelIDs.append($0.labelID)
                        }
                    })
                case .milestone:
                    selected.forEach({
                        if let milestone = $0.milestone {
                            self.milestoneStackView.addArrangedSubview(milestone)
                            self.milestoneIDs.append($0.milestoneID ?? 0)
                        }
                    })
                }
            }
    }

    private func configureObservers() {
        keyboardShowObserver = NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillShowNotification)
            .sink { [weak self] notification in self?.keyboardWillShow(notification) }
        
        keyboardHideObserver = NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillHideNotification)
            .sink { [weak self] _ in self?.keyboardWillHide() }
    }
    
    private func toggleRightBarButtonItem(isEnable: Bool) {
        doneRightBarButton.isEnabled = isEnable
        doneRightBarButton.tintColor = (isEnable) ? nil : .clear
    }
    
    // MARK: Actions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        let keyboardRect =  keyboardFrame.cgRectValue
        if commentTextView.frame.maxY > keyboardRect.origin.y {
            commentTextViewBottomConstraint.constant = commentTextView.frame.maxY - keyboardRect.origin.y + 100
        }
    }

    private func keyboardWillHide() {
        commentTextViewBottomConstraint.constant = 8
    }
    
    @IBAction func markdownSegmentedControlChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            removeMarkdownPreview()
        case 1:
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
        
        if let issueNumber = issueNumber, isEdit {
            interactor.editIssue(id: issueNumber,
                                 title: titleTextField.text ?? "",
                                 comment: commentTextView.text,
                                 milestoneID: milestoneIDs.first) {
                DispatchQueue.main.async {
                    NotificationCenter
                        .default
                        .post(.init(name: Notification.Name(rawValue: "createIssueClosed"),
                                    userInfo: ["issueNumber": self.issueNumber ?? 0]))
                    self.dismiss(animated: true)
                }
            }
            
            if !labelStackView.subviews.isEmpty {
                interactor.uploadLabel(id: issueNumber, labelIDs: labelIDs)
            }
            
            if !assigneeStackView.subviews.isEmpty {
                interactor.uploadAssignee(id: issueNumber, assigneeIDs: assigneeIDs)
            }
        } else {
            interactor.uploadIssue(title: titleTextField.text ?? "", comment: commentTextView.text, milestoneID: 0)
            self.dismiss(animated: true)
        }
    }

    @IBAction func cancelTouched(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func assigneeEditTouched(_ sender: Any) {
        editViewController(editType: .assignee)
    }
    
    @IBAction func labelEditTouched(_ sender: Any) {
        editViewController(editType: .label)
    }
    
    @IBAction func milestoneEditTouched(_ sender: Any) {
        editViewController(editType: .milestone)
    }

    func editViewController(editType: EditViewController.EditType) {
        let storyboard = UIStoryboard(name: "IssueList", bundle: nil)
        let viewController = storyboard
            .instantiateViewController(identifier: "EditViewController",
                                       creator: { coder -> EditViewController? in
                                        return EditViewController(coder: coder,
                                                                  id: self.issueNumber,
                                                                  editType: editType,
                                                                  labels: self.labels,
                                                                  milestone: self.milestone)
                                       })
        present(viewController, animated: true)
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
    }
    
    private func loadMarkdownPreview() {
        configureMarkdownPreview()
        commentTextView.isHidden = true
        markdownPreview?.load(markdown: commentTextView.text)
    }
    
    private func removeMarkdownPreview() {
        markdownPreview?.removeFromSuperview()
        markdownPreview = nil
        commentTextView.isHidden = false
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
        toggleRightBarButtonItem(isEnable: true)
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            configurePlaceholder()
        }
        commentTextView.resignFirstResponder()
        toggleRightBarButtonItem(isEnable: false)
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
