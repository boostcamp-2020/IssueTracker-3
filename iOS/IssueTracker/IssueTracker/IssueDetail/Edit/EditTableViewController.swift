//
//  EditTableViewController.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/12.
//

import UIKit

class EditTableViewController: UITableViewController {

    private var dataqSource: EditDataSource!

    enum Section: Int, CaseIterable, CustomStringConvertible {
        case selected
        case list

        var description: String {
            switch self {
            case .selected: return "Selected"
            case .list: return "List"
            }
        }
    }

    class EditDataSource: UITableViewDiffableDataSource<Section, IssueFilterViewModel> {
        override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            let sectionKind = Section(rawValue: section)
            return sectionKind?.description
        }
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

extension EditIssueViewController {

}

struct IssueDetailEditViewModel: Hashable {

    let identifier = UUID()

}
