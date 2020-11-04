//
//  IssueListViewController.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/02.
//

import UIKit

// TODO: Activity Indicators
// TODO: ios13 이하 버전 Edit 구현

class IssueListViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet private weak var issueListCollectionView: UICollectionView!
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, IssueListViewModel>!
    private var issueListModelController: IssueListModelController!
    
    private lazy var issueList: [IssueListViewModel] = {
        return generateIssues()
    }()
    
    // MARK: Enums
    
    enum Section: CaseIterable {
        case main
    }
    
    // MARK: View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItems()
        configureCollectionLayoutList()
        configureDataSource()
        
        issueListModelController = IssueListModelController()
        performQuery(with: nil)
    }
    
    // MARK: Configure
    
    private func configureNavigationItems() {
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController?.searchBar.delegate = self
        navigationItem.rightBarButtonItem = editButtonItem
    }
    
    private func configureCollectionLayoutList() {
        if #available(iOS 14.0, *) {
            var layoutConfig = UICollectionLayoutListConfiguration(appearance: .plain)
            layoutConfig.trailingSwipeActionsConfigurationProvider = { [weak self] indexPath in
                guard let self = self,
                      let item = self.dataSource.itemIdentifier(for: indexPath)
                else {
                    return nil
                }
                
                let delete = UIContextualAction(style: .normal, title: "Delete") { action, view, completion in
                    completion(true)
                }
                
                delete.backgroundColor = .systemRed
                
                return UISwipeActionsConfiguration(actions: [delete])
            }
            let listLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)
            issueListCollectionView.collectionViewLayout = listLayout
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        guard segue.identifier == "IssueDetailSegue",
        //              let issueDetailVC = segue.destination as? IssueDetailViewController
        //        else {
        //            return
        //        }
        // issue 정보 넘기기
    }
    
    // MARK: Action Functions

    //    @IBAction func editButtonTouched(_ sender: UIBarButtonItem) {
    //        setEditing(true, animated: true)
    //    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if #available(iOS 14.0, *) {
            issueListCollectionView.isEditing = editing
            issueListCollectionView.allowsMultipleSelectionDuringEditing = editing
        } else {
            // TODO: editing flag
            issueListCollectionView.allowsMultipleSelection = editing
        }
        
        issueListCollectionView
            .indexPathsForVisibleItems
            .map { issueListCollectionView.cellForItem(at: $0) }
            .compactMap { $0 as? IssueListCollectionViewCell }
            .forEach { $0.isInEditingMode = editing }
        /* 아래의 코드 위로 변경함 - 협업 코드 이해용 - 삭제 예정
        issueListCollectionView.indexPathsForVisibleItems.forEach { indexPath in
            guard let cell = issueListCollectionView.cellForItem(at: indexPath)
                    as? IssueListCollectionViewCell
            else {
                return
            }
            cell.isInEditingMode = editing
        }
         */
    }
}

// MARK: CollectionView DataSource

extension IssueListViewController {
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, IssueListViewModel>(
            collectionView: issueListCollectionView,
            cellProvider: {(
                collectionView, indexPath, item
            ) -> UICollectionViewCell? in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IssueListCell", for: indexPath)
                        as? IssueListCollectionViewCell else { return UICollectionViewCell() }
                
                cell.configureIssueListCell(of: item)
                
                if #available(iOS 14.0, *) {
                    cell.accessories = [.multiselect(displayed: .whenEditing, options: .init())]
                }
                return cell
            })
    }
}

// MARK: UICollectionViewDelegate

extension IssueListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard isEditing else {
            performSegue(withIdentifier: "IssueDetailSegue", sender: nil)
            return
        }
        /* 아래의 코드 위로 변경함 - 협업 코드 이해용 - 삭제 예정
        guard let storyboard = UIStoryboard(name: "IssueList", bundle: nil)
                .instantiateViewController(identifier: "IssueDetailViewController")
                as? IssueDetailViewController else {
            return
        }
        navigationController?.pushViewController(storyboard, animated: true)
         */
    }
    
    func collectionView(_ collectionView: UICollectionView, didBeginMultipleSelectionInteractionAt indexPath: IndexPath) {
        
    }
}

// MARK: UISearchBarDelegate

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

// MARK: Dummy Issue Data

extension IssueListViewController {
    private func generateIssues() -> [IssueListViewModel] {
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
}
