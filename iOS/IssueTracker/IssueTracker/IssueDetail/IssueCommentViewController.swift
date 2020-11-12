//
//  IssueCommentViewController.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/13.
//

import UIKit

final class IssueCommentViewController: UIViewController {
    
    @IBOutlet private weak var commentTextView: UITextView!
    
    private let networkService = NetworkService()
    private var addComment: AddComment?
    var issueID: Int?
    var completionHandler: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func uploadTouched(_ sender: UIBarButtonItem) {
        view.endEditing(true)
        uploadComment(handler: completionHandler)
    }
    
    @IBAction func cancelTouched(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    private func uploadComment(handler: (() -> Void)?) {
        guard let issueID = issueID else { return }
        addComment = AddComment(id: issueID, text: commentTextView.text)
        guard let data = addComment?.encoded() else {
            debugPrint("uploadIssue encoding error")
            return
        }
        networkService.request(apiConfiguration: IssueDetailEndPoint.postComment(data)) { [weak self] result in
            switch result {
            case .failure(let error):
                debugPrint(error)
                return
            case .success(_: ):
                DispatchQueue.main.async {
                    self?.dismiss(animated: true, completion: nil)
                    guard let handler = handler else { return }
                    handler()
                }
                return
            }
        }
    }
}

struct AddComment: Codable {
    let issueID: Int
    let userID: Int
    let body: String
    let emoji: String?
    
    init(id: Int, text: String) {
        issueID = id
        userID = 1
        body = text
        emoji = nil
    }
    
    enum CodingKeys: String, CodingKey {
        case body, emoji
        case issueID = "issue_id"
        case userID = "user_id"
    }
}
