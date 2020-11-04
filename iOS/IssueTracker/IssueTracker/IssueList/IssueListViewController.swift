//
//  IssueListViewController.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/02.
//

import UIKit

// TODO: Activity Indicators
// TODO: ios13 이하 버전 Edit 구현

// TODO: 나머지 버튼들 추가 + 액션함수 + 기능 (select All / deselectAll / 이슈 닫기 + reloadData)
// let items = myCollectionView.indexPathsForSelectedItems

class IssueListViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet private weak var issueListCollectionView: UICollectionView!
    @IBOutlet private weak var issueListToolBar: UIToolbar!
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, IssueListViewModel>!
    private var issueListModelController: IssueListModelController!
//    private var selectedCellIndexPaths = [IndexPath]()
    
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
    
    /// NavigationBar Edit 버튼 -> (UIKit) VC의 Editable View -> setEditing action 함수 호출
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
//        selectedCellIndexPaths.removeAll()
        tabBarController?.tabBar.isHidden.toggle()
        issueListToolBar.isHidden.toggle()
//        navigationItem.leftBarButtonItem = editing ?
        
        if editing {
            navigationItem.rightBarButtonItem?.title = "Cancel"
            navigationItem.rightBarButtonItem?.style = .plain
            navigationItem.leftBarButtonItem?.title = "Select All"
        }
        
        /// collectionView Editing Mode
        if #available(iOS 14.0, *) {
            issueListCollectionView.isEditing = editing
            issueListCollectionView.allowsMultipleSelectionDuringEditing = editing
        } else {
            // TODO: editing Mode flag
            issueListCollectionView.allowsMultipleSelection = editing
        }
        
        /// 모든 Cell isInEditingMode propery에 넣기 editing(edit mode : true / 끄면 : false)
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
    
    @IBAction func closeSelectedIssueTouched(_ sender: UIBarButtonItem) {
//        issueListCollectionView
//            .indexPathsForSelectedItems?
            
//            .map { issueListCollectionView.cellForItem(at: $0) }
//            .compactMap { $0 as? IssueListCollectionViewCell }
//            .forEach { }
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
        
        // selectedCellIndexPaths.append(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        guard let cell = cell as? IssueListCollectionViewCell else { return }
        
        if isEditing != cell.isInEditingMode {
            cell.isInEditingMode = isEditing
        }
    }
    
    //    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    //        selectedCellIndexPaths = selectedCellIndexPaths.filter { $0 != indexPath }
    //    }
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
        (1...10).forEach { _ in
            issues.append(IssueListViewModel(title: "haha",
                                             description: "설명",
                                             milestone: "프로젝트5",
                                             labels: ["label1, label2"]))
        }
        return issues
    }
}
