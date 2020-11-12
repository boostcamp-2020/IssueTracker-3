//
//  IssueFilterViewController.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/02.
//

import UIKit

class IssueFilterViewController: UIViewController {
    @IBOutlet weak var issueFilterTableView: UITableView!

    var dataSource: DataSource!

    private lazy var issueTopFilter: [IssueFilterViewModel] = {
        return generateTopFilters()
    }()

    private lazy var issueBottomFilter: [IssueFilterViewModel] = {
        return generateBottomFilters()
    }()

    enum Section: Int, Hashable, CaseIterable, CustomStringConvertible {
        case condition, detailedCondition

        var description: String {
            switch self {
            case .condition: return "다음 중에 조건을 고르세요"
            case .detailedCondition: return "세부 조건"
            }
        }
    }

    class DataSource: UITableViewDiffableDataSource<Section, IssueFilterViewModel> {
        override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            let sectionKind = Section(rawValue: section)
            return sectionKind?.description
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        issueFilterTableView.separatorStyle = .none
        issueFilterTableView.allowsMultipleSelection = true

        configureDataSource()
        performQuery()
    }

    @IBAction func cancelButtonTouched(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonTouched(_ sender: UIBarButtonItem) {
        var issueFilter = issueTopFilter + issueBottomFilter
        issueFilter = issueFilter
            .filter({$0.chevronDirection.contains(.check)})
            .filter({!$0.isChevron}).map({$0})
        print(issueFilter.map({$0.title}))
        dismiss(animated: true)
    }
}

extension IssueFilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedItem = dataSource.itemIdentifier(for: indexPath),
              let cell = tableView.cellForRow(at: indexPath) as? IssueFilterTableViewCell
        else { return }

        if selectedItem.childItem.count > 0 {
            selectedItem.isChevron = true

            issueBottomFilter.insert(contentsOf: selectedItem.childItem, at: indexPath.row + 1)
            performQuery()
        } else {
            selectedItem.isChevron = false
        }

        cell.configure(withViewModel: selectedItem)
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let selectedItem = dataSource.itemIdentifier(for: indexPath),
              let cell = tableView.cellForRow(at: indexPath) as? IssueFilterTableViewCell
        else { return }

        if selectedItem.childItem.count > 0 {
            selectedItem.isChevron = false

            let range = indexPath.row + 1...indexPath.row + selectedItem.childItem.count
            issueBottomFilter.removeSubrange(range)
            performQuery()
        } else {
            selectedItem.isChevron = true
        }

        cell.configure(withViewModel: selectedItem)
    }
}

extension IssueFilterViewController {
    func configureDataSource() {
        dataSource = DataSource(
            tableView: issueFilterTableView,
            cellProvider: {( tableView, indexPath, item) -> UITableViewCell? in
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: "IssueFilterTableViewCell", for: indexPath
                ) as? IssueFilterTableViewCell else {
                    return UITableViewCell()
                }
                cell.configure(withViewModel: item)

                return cell
            })
    }

    func performQuery() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, IssueFilterViewModel>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(issueTopFilter, toSection: .condition)
        snapshot.appendItems(issueBottomFilter, toSection: .detailedCondition)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

private func generateTopFilters() -> [IssueFilterViewModel] {
    var filters = [IssueFilterViewModel]()
    filters.append(IssueFilterViewModel(title: .openIssue,
                                        chevronDirection: [.check],
                                        isChevron: true,
                                        hasChildren: false))
    filters.append(IssueFilterViewModel(title: .write,
                                        chevronDirection: [.check],
                                        isChevron: true,
                                        hasChildren: false))
    filters.append(IssueFilterViewModel(title: .assignment,
                                        chevronDirection: [.check],
                                        isChevron: true,
                                        hasChildren: false))
    filters.append(IssueFilterViewModel(title: .comment,
                                        chevronDirection: [.check],
                                        isChevron: true,
                                        hasChildren: false))
    filters.append(IssueFilterViewModel(title: .closeIssue,
                                        chevronDirection: [.check],
                                        isChevron: true,
                                        hasChildren: false))
    return filters
}

private func generateBottomFilters() -> [IssueFilterViewModel] {
    var filters = [IssueFilterViewModel]()

    filters.append(IssueFilterViewModel(title: .author,
                                        chevronDirection: [.right, .down],
                                        isChevron: false,
                                        hasChildren: true,
                                        childItem: [
                                            IssueFilterViewModel(title: .child("author1"),
                                                                 chevronDirection: [.check],
                                                                 isChevron: true),
                                            IssueFilterViewModel(title: .child("author1"),
                                                                 chevronDirection: [.check],
                                                                 isChevron: true)
                                        ]))
    filters.append(IssueFilterViewModel(title: .label,
                                        chevronDirection: [.right, .down],
                                        isChevron: false,
                                        hasChildren: true,
                                        childItem: [
                                            IssueFilterViewModel(title: .child("label1"),
                                                                 chevronDirection: [.check],
                                                                 isChevron: true),
                                            IssueFilterViewModel(title: .child("label2"),
                                                                 chevronDirection: [.check],
                                                                 isChevron: true)
                                        ]))
    filters.append(IssueFilterViewModel(title: .milestone,
                                        chevronDirection: [.right, .down],
                                        isChevron: false,
                                        hasChildren: true,
                                        childItem: [
                                            IssueFilterViewModel(title: .child("milestone1"),
                                                                 chevronDirection: [.check],
                                                                 isChevron: true),
                                            IssueFilterViewModel(title: .child("milestone2"),
                                                                 chevronDirection: [.check],
                                                                 isChevron: true)
                                        ]))
    filters.append(IssueFilterViewModel(title: .assignee,
                                        chevronDirection: [.right, .down],
                                        isChevron: false,
                                        hasChildren: true,
                                        childItem: [
                                            IssueFilterViewModel(title: .child("assignee1"),
                                                                 chevronDirection: [.check],
                                                                 isChevron: true),
                                            IssueFilterViewModel(title: .child("assignee2"),
                                                                 chevronDirection: [.check],
                                                                 isChevron: true),
                                            IssueFilterViewModel(title: .child("assignee3"),
                                                                 chevronDirection: [.check],
                                                                 isChevron: true),
                                            IssueFilterViewModel(title: .child("assignee4"),
                                                                 chevronDirection: [.check],
                                                                 isChevron: true)
                                        ]))
    return filters
}

enum Filter: Hashable, CustomStringConvertible {
    case openIssue, write, assignment, comment, closeIssue
    case author, label, milestone, assignee
    case child(String)

    var description: String {
        switch self {
        case .openIssue: return "열린 이슈들"
        case .write: return "내가 작성한 이슈들"
        case .assignment: return "나한테 할당된 이슈들"
        case .comment: return "내가 댓글을 남긴 이슈들"
        case .closeIssue: return "닫힌 이슈들"

        case .author: return "작성자"
        case .label: return "레이블"
        case .milestone: return "마일스톤"
        case .assignee: return "담당자"

        case .child(let title): return title
        }
    }
}
