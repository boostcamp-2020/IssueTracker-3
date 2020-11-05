//
//  IssueListViewController.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/02.
//

import UIKit
import Combine

// TODO: Activity Indicators
// TODO: ios13 이하 버전 Edit 구현

// FIXME: tabBarButton & toolBarButton hidden 오류
class IssueListViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet private weak var issueListCollectionView: UICollectionView!
    @IBOutlet private weak var issueListToolBar: UIToolbar!
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, IssueListViewModel>!
    private var issueListModelController: IssueListModelController!
    private var filterLeftBarButton: UIBarButtonItem!
    private var selectAllLeftBarButton: UIBarButtonItem!
    var searchText: String = ""

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

        navigationItem.searchController = UISearchController(searchResultsController: nil)
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController?.searchBar.delegate = self

        issueListModelController = IssueListModelController()
        configureDataSource()
        performSearchQuery(with: nil)


        configureNavigationItems()
        configureCollectionLayoutList()
 
    }
    
    // MARK: Configure
    
    private func configureNavigationItems() {
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController?.searchBar.delegate = self
        
        /// Navigation Item BarButton들은 hidden 프로퍼티가 없고 / 두 개를 상황 마다 번갈아가며 써야하기 때문에, 직접 만들었음.
        filterLeftBarButton = UIBarButtonItem(title: "Filter",
                                              style: .plain,
                                              target: self,
                                              action: #selector(filterTouched))
        selectAllLeftBarButton = UIBarButtonItem(title: "Select All",
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(selectAllTouched))
        navigationItem.leftBarButtonItem = filterLeftBarButton
        navigationItem.rightBarButtonItem = editButtonItem
        issueListToolBar.isHidden = true
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

                                                                      
                let delete = UIContextualAction(style: .destructive,
                                                title: "Delete") { [weak self] action, view, completion in
                    // TODO: Model -> 해당 indexPath delete
                    var snapshot = self?.dataSource.snapshot()
                    snapshot?.deleteItems([item])
                    guard let snapShot = snapshot else { return }
                    self?.dataSource.apply(snapShot, animatingDifferences: true)
                    self?.issueListCollectionView.reloadData()
                    // TODO: 선택 이슈 삭제 -> 삭제 이슈 Model Update & Server Post
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
    
    /// NavigationBar Edit 버튼 -> (UIKit) VC의 Editable View -> setEditing action 함수 호출
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        tabBarController?.tabBar.isHidden = editing
        issueListToolBar.isHidden = !editing
        navigationItem.leftBarButtonItem = editing ? selectAllLeftBarButton : filterLeftBarButton
        if editing {
            navigationItem.rightBarButtonItem?.title = "Cancel"
            navigationItem.rightBarButtonItem?.style = .plain
        }
        
        /// collectionView Editing Mode
        if #available(iOS 14.0, *) {
            issueListCollectionView.isEditing = editing
            issueListCollectionView.allowsMultipleSelectionDuringEditing = editing
        } else {
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
        //        guard let selectedItems = issueListCollectionView.indexPathsForSelectedItems else {
        //            return
        //        }
        var snapshot = dataSource.snapshot()
        let selectedItems = issueListCollectionView
            .indexPathsForSelectedItems?
            .compactMap { dataSource.itemIdentifier(for: $0) }
        guard let deleteItems = selectedItems else {
            return
        }
        snapshot.deleteItems(deleteItems)
        dataSource.apply(snapshot, animatingDifferences: true)
        
        // TODO: 선택 이슈 닫기 -> 닫은 이슈 Model Update & Server Post
        // selectedItems
        //    .map { issueListCollectionView.cellForItem(at: $0) }
        //    .compactMap { $0 as? IssueListCollectionViewCell }
        //    .publisher
        //    .assign(to: &)
        issueListCollectionView.reloadData()
    }
    
    @objc private func filterTouched(_ sender: Any) {
        performSegue(withIdentifier: "IssueListFilterSegue", sender: nil)
    }
    
    @objc private func selectAllTouched(_ sender: Any) {
        // TODO: issue ViewModel List 가지고 있는 객체에서 -> forEach -> isSelect true
        issueListCollectionView
            .indexPathsForVisibleItems
            .map { issueListCollectionView.cellForItem(at: $0) }
            .compactMap { $0 as? IssueListCollectionViewCell }
            .forEach { $0.isSelected.toggle() }
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


                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IssueListCell", for: indexPath)
                        as? IssueListCollectionViewCell else { return UICollectionViewCell() }
                
                cell.configureLabelStackView(milestone: item.milestone, labels: item.labels)
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
