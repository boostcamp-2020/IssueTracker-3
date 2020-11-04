//
//  IssueListViewController.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/02.
//

import UIKit

class IssueListViewController: UIViewController {

    enum Section: CaseIterable {
        case main
    }

    @IBOutlet weak var issueListCollectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, IssueListViewModel>!
    var issueListModelController: IssueListModelController!

    var searchText: String = ""

    private lazy var issueList: [IssueListViewModel] = {
        return generateMountains()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.searchController = UISearchController(searchResultsController: nil)
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController?.searchBar.delegate = self

        issueListModelController = IssueListModelController()
        configureDataSource()
        performSearchQuery(with: nil)

        if #available(iOS 14.0, *) {
            var layoutConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
            layoutConfig.trailingSwipeActionsConfigurationProvider = { [weak self] (indexPath) in
                guard let self = self,
                      let item = self.dataSource.itemIdentifier(for: indexPath)
                else {
                    return nil
                }

                let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
                    completion(true)
                }

                delete.backgroundColor = .systemRed

                return UISwipeActionsConfiguration(actions: [delete])
            }
            let listLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)
            issueListCollectionView.collectionViewLayout = listLayout
        } else {

        }
    }
}

extension IssueListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        performSearchQuery(with: searchText)
        self.searchText = searchText
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.navigationItem.searchController?.searchBar.text = searchText
    }
}

extension IssueListViewController {
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, IssueListViewModel>(
            collectionView: issueListCollectionView,
            cellProvider: {(
                collectionView, indexPath, item
            ) -> UICollectionViewCell? in
                guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: "IssueListCell", for: indexPath
                ) as? IssueListCollectionViewCell else { return UICollectionViewCell() }

                cell.titleLabel.text = item.title
                cell.issueListDescription.text = item.description
                cell.configureLabelStackView(milestone: item.milestone, labels: item.labels)

                return cell
            })
    }
}

extension IssueListViewController {
    func performSearchQuery(with filter: String?) {
        let issueListItems = issueListModelController.filtered(with: filter ?? "",
                                                               model: issueList).sorted { $0.title < $1.title }

        var snapshot = NSDiffableDataSourceSnapshot<Section, IssueListViewModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(issueListItems)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    func performAddQuery(with model: IssueListViewModel) {
        let issueListItems = issueListModelController.add(model: model, to: issueList)
        var snapshot = NSDiffableDataSourceSnapshot<Section, IssueListViewModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(issueListItems)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension IssueListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let storyboard = UIStoryboard(name: "IssueList", bundle: nil)
                .instantiateViewController(identifier: "IssueDetailViewController")
                as? IssueDetailViewController else { return }
        
        navigationController?.pushViewController(storyboard, animated: true)
    }
}

private func generateMountains() -> [IssueListViewModel] {
    var issues = [IssueListViewModel]()
    issues.append(IssueListViewModel(title: "test1",
                                     description: "설명",
                                     milestone: "프로젝트1",
                                     labels: ["label1", "label2"]))
    issues.append(IssueListViewModel(title: "test2",
                                     description: "설명",
                                     milestone: "프로젝트2",
                                     labels: ["label1", "label2"]))
    issues.append(IssueListViewModel(title: "test3",
                                     description: "설명",
                                     milestone: "프로젝트3",
                                     labels: ["label1", "label2"]))
    issues.append(IssueListViewModel(title: "ha",
                                     description: "설명",
                                     milestone: "프로젝트4",
                                     labels: ["label1", "label2", "label3", "label3"]))
    issues.append(IssueListViewModel(title: "haha",
                                     description: "설명",
                                     milestone: "프로젝트5",
                                     labels: ["label1", "label2"]))
    return issues
}
