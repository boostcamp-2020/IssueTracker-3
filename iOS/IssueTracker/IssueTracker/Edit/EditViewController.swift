//
//  EditTableViewController.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/12.
//

import UIKit

protocol EditDisplayLogic: class {
    func displayFetchAll(viewModel: [IssueDetailEditViewModel])
}

final class EditViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var editTableView: UITableView!
    
    private let id: Int?
    private let editType: EditType?
    private let labels: [CustomButtonView]?
    private let milestone: CustomButtonView?
    
    private var dataSource: EditDataSource!
    private var interactor: EditBusinessLogic!
    private var displayedSelected = [IssueDetailEditViewModel]()
    private var displayedList = [IssueDetailEditViewModel]()
    
    // MARK: Enum

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
    
    enum EditType {
        case assignee
        case label
        case milestone
    }
    
    // MARK: Nested Class

    class EditDataSource: UITableViewDiffableDataSource<Section, IssueDetailEditViewModel> {
        override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            let sectionKind = Section(rawValue: section)
            return sectionKind?.description
        }
    }

    // MARK: View Cycle
    
    init?(coder: NSCoder,
          id: Int?,
          editType: EditType,
          labels: [CustomButtonView]?,
          milestone: CustomButtonView?) {
        self.id = id
        self.editType = editType
        self.labels = labels
        self.milestone = milestone
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        self.id = nil
        self.editType = nil
        self.labels = nil
        self.milestone = nil
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
    
    // MARK: Setup

    private func setup() {
        let interactor = EditInteractor()
        let presenter = EditPresenter()
        self.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = self
    }

    // MARK: Configure

    func configureDataSource() {
        dataSource = EditDataSource(
            tableView: editTableView,
            cellProvider: {( tableView, indexPath, item) -> UITableViewCell? in
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: "EditTableViewCell", for: indexPath
                ) as? EditTableViewCell else {
                    return UITableViewCell()
                }
                guard let editType = self.editType else { return cell }
                switch editType {
                case .assignee:
                    if let assignee = item.assignee {
                        cell.configure(button: assignee)
                    }
                case .label:
                    if let labels = item.labels {
                        cell.configure(button: labels)
                    }
                case .milestone:
                    if let milestone = item.milestone {
                        cell.configure(button: milestone)
                    }
                }
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
    
    // MARK: Actions
    
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

// MARK: EditDisplayLogic

extension EditViewController: EditDisplayLogic {
    func displayFetchAll(viewModel: [IssueDetailEditViewModel]) {
        displayedList = viewModel
        performQuery()
    }
}

// MARK: UITableViewDelegate

extension EditViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let editType = editType else { return }

        guard !(indexPath.section == 1 && editType == .milestone && !displayedSelected.isEmpty) else {
            tableView.shake()
            return
        }

        guard let selectedItem = dataSource.itemIdentifier(for: indexPath),
              let cell = tableView.cellForRow(at: indexPath) as? EditTableViewCell else { return }

        if indexPath.section == 0 {
            cell.changeButtonImage(buttonType: .seleted)
            displayedList.append(selectedItem)
            guard let index = displayedSelected.firstIndex(of: selectedItem) else { return }
            displayedSelected.remove(at: index)
        } else {
            cell.changeButtonImage(buttonType: .list)
            displayedSelected.append(selectedItem)
            guard let index = displayedList.firstIndex(of: selectedItem) else { return }
            displayedList.remove(at: index)
        }

        performQuery()
    }
}
