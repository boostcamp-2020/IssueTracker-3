//
//  EditTableViewController.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/12.
//

import UIKit

class EditTableViewController: UITableViewController {

    private var dataqSource: UITableViewDiffableDataSource<Section, IssueDetailEditViewModel>!

    enum Section {
        case selected
        case list
    }

    enum EditType {
        case author
        case label
        case milestone
    }

    private let id: Int?
    private let editType: EditType?

    init?(coder: NSCoder, id: Int, editType: EditType) {
        self.id = id
        self.editType = editType
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        self.id = nil
        self.editType = nil
        super.init(coder: coder)
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
