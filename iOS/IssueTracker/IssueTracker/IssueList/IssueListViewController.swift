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
        performQuery(with: nil)
    }
}

extension IssueListViewController {
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, IssueListViewModel>(
            collectionView: issueListCollectionView,
            cellProvider: {(
                collectionView, indexPath, item
            ) -> UICollectionViewCell? in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IssueListCell", for: indexPath) as? IssueListCollectionViewCell else { return UICollectionViewCell() }

                cell.titleLabel.text = item.title
                cell.issueListDescription.text = item.description
                cell.firstLabel.titleLabel?.text = item.labels.first
                cell.secondLabel.titleLabel?.text = item.labels.last
                cell.mileStone.titleLabel?.text = item.milestone
                return cell
            })
    }
}

extension IssueListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        performQuery(with: searchText)
    }

    func performQuery(with filter: String?) {
        let issueListItems = issueListModelController.filtered(with: filter ?? "",
                                                               model: issueList).sorted { $0.title < $1.title }
        
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
                                     labels: ["label1, label2"]))
    issues.append(IssueListViewModel(title: "test2",
                                     description: "설명",
                                     milestone: "프로젝트2",
                                     labels: ["label1, label2"]))
    issues.append(IssueListViewModel(title: "test3",
                                     description: "설명",
                                     milestone: "프로젝트3",
                                     labels: ["label1, label2"]))
    issues.append(IssueListViewModel(title: "ha",
                                     description: "설명",
                                     milestone: "프로젝트4",
                                     labels: ["label1, label2"]))
    issues.append(IssueListViewModel(title: "haha",
                                     description: "설명",
                                     milestone: "프로젝트5",
                                     labels: ["label1, label2"]))
    return issues
}