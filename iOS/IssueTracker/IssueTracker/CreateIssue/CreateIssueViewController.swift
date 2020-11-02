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
        configureMenuControllerItems()
    }
    
    private func configureMenuControllerItems() {
        UIMenuController.shared.setMenuVisible(true, animated: true)
        let imagePicker = UIMenuItem(title: "Insert Photo", action: #selector(insertPhotoDidTap))
        UIMenuController.shared.menuItems?.append(imagePicker)
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any!) -> Bool {
        action == #selector(insertPhotoDidTap)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        commentWritingTextView.resignFirstResponder()
        return true
    }
    
    @objc func insertPhotoDidTap(sender: UIMenuItem) {
        print("image picker")
    }
}
