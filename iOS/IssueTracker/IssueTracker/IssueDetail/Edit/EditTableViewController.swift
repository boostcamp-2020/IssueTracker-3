//
//  EditTableViewController.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/12.
//

import UIKit

class EditTableViewController: UITableViewController {

    private var dataSource: UITableViewDiffableDataSource<Section, IssueDetailEditViewModel>!

    enum Section {
        case selected
        case list
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func configureDataSource() {

    }
}

struct IssueDetailEditViewModel: Hashable {
    let identifier = UUID()

}
