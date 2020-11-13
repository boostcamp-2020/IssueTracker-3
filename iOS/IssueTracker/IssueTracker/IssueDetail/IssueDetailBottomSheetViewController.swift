//
//  IssueDetailBottomSheetViewController.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/03.
//

import UIKit

class IssueDetailBottomSheetViewController: UIViewController {
    
    @IBOutlet weak var handleArea: UIView!
    @IBOutlet weak var addCommentButton: UIButton!
    @IBOutlet weak var upButtom: UIButton!
    @IBOutlet weak var downButton: UIButton!
    
    weak var delegate: IssueDetailBottomSheetDelegate?
    var issueID: Int?
    
    @IBAction func addCommentTouched(_ sender: Any) {
        delegate?.addCommentViewShouldAppear()
    }
    
    @IBAction func scrollUpTouched(_ sender: Any) {
        delegate?.issueDetailViewShouldScrollUp()
    }
    
    @IBAction func scrollDownTouched(_ sender: Any) {
        delegate?.issueDetailViewShouldScrollDown()
    }
    
    @IBAction func closeIssueTouched(_ sender: Any) {
        delegate?.issueDetailViewShouldCloseIssue()
    }
}
