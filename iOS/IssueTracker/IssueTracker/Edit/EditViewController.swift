//
//  EditTableViewController.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/12.
//

import UIKit

protocol EditDisplayLogic: class {
    func displayFetchAllGetUser(viewModel: [IssueDetailEditViewModel])
}

class EditViewController: UIViewController, EditDisplayLogic {
    @IBOutlet weak var editTableView: UITableView!
    private var dataSource: EditDataSource!
    private var interactor: EditBusinessLogic!

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

    class EditDataSource: UITableViewDiffableDataSource<Section, IssueDetailEditViewModel> {
        override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            let sectionKind = Section(rawValue: section)
            return sectionKind?.description
        }
    }

    enum EditType {
        case assignee
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
        configureDataSource()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        switch editType {
        case .assignee:
            interactor.fetchAllGetUser()
        case .label:
            interactor.fetchAllGetLabel()
        case .milestone:
            interactor.fetchAllGetMilestone()
        case .none:
            break
        }
    }

    private func setup() {
        let interactor = EditInteractor()
        let presenter = EditPresenter()
        self.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = self
    }

    private var displayedSelected = [IssueDetailEditViewModel]()
    private var displayedList = [IssueDetailEditViewModel]()

    func displayFetchAllGetUser(viewModel: [IssueDetailEditViewModel]) {
        displayedList = viewModel
        performQuery()
    }

    func configureDataSource() {
        dataSource = EditDataSource(
            tableView: editTableView,
            cellProvider: {( tableView, indexPath, item) -> UITableViewCell? in
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: "EditTableViewCell", for: indexPath
                ) as? EditTableViewCell else {
                    return UITableViewCell()
                }

                cell.configureSeleted(title: item.title)
                cell.configureList(title: item.title)

                return cell
            })
    }

    func performQuery() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, IssueDetailEditViewModel>()
        snapshot.appendSections([.selected])
        snapshot.appendItems(displayedSelected)
        
        snapshot.appendSections([.list])
        snapshot.appendItems(displayedList)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    @IBAction func cancelTouched(_ sender: Any) {
        dismiss(animated: true)
    }

    @IBAction func doneTouched(_ sender: Any) {
        guard let type = self.editType else { return }
        dismiss(animated: true) {
            NotificationCenter
                .default
                .post(name: Notification.Name(rawValue: "EditViewController"),
                      object: nil,
                      userInfo: ["selected": self.displayedSelected,
                                 "type": type ])
            
        }
    }
}

extension EditViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedItem = dataSource.itemIdentifier(for: indexPath),
              let cell = tableView.cellForRow(at: indexPath) as? EditTableViewCell else { return }

        if indexPath.section == 0 {
            cell.chagneButtonImage(buttonType: .seleted)
            displayedList.append(selectedItem)
            guard let index = displayedSelected.firstIndex(of: selectedItem) else { return }
            displayedSelected.remove(at: index)
        } else {
            cell.chagneButtonImage(buttonType: .list)
            displayedSelected.append(selectedItem)
            guard let index = displayedList.firstIndex(of: selectedItem) else { return }
            displayedList.remove(at: index)
        }

        performQuery()
    }
}
