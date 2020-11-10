//
//  IssueListViewController.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/02.
//

import UIKit
import Combine
import WebKit
// TODO: Activity Indicators
// TODO: ios13 이하 버전 Edit 구현

// FIXME: 플로팅 버튼 (shade / 에니메이션 - (스크롤:숨기기 / 끝나면:나오기 / edit mode 없애기)

// FIXME: tabBarButton & toolBarButton hidden 오류
// FIXME: SelectAll 문제 - 전체 다 안됨 (겉으로 보기에만 됨 / 여러번 하면 오류 + cell 위치 틀리는 문제 / Model data를 변경해야함)

protocol IssueListDisplayLogic: class {
  func displayFetchedIssues(viewModel: [IssueListViewModel])
}

class IssueListViewController: UIViewController, IssueListDisplayLogic {
    
    // MARK: Properties
    
    @IBOutlet private weak var issueListCollectionView: UICollectionView!
    @IBOutlet private weak var issueListToolBar: UIToolbar!
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, IssueListViewModel>!

    private var issueListModelController: IssueListModelController!
    
    private var filterLeftBarButton: UIBarButtonItem!
    private var selectAllLeftBarButton: UIBarButtonItem!
    private var isSelectedAll = false
    private var searchText = ""
    private var interactor: IssueListBusinessLogic!

    // MARK: Enums
    
    enum Section: CaseIterable {
        case main
    }
    
    // MARK: View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        issueListModelController = IssueListModelController()

        configureNavigationItems()
        configureDataSource()
        configureCollectionLayoutList()
        performSearchQuery(with: nil)
        showSearchBar()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        issueListToolBar.isHidden = true
        interactor.fetchIssues()
    }

    private var displayedStore = [IssueListViewModel]()

    func displayFetchedIssues(viewModel: [IssueListViewModel]) {
        displayedStore = viewModel
        var snapshot = NSDiffableDataSourceSnapshot<Section, IssueListViewModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(displayedStore)
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = IssueListInteractor()
        let presenter = IssueListPresenter()
        self.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    // MARK: Configure
    
    private func configureNavigationItems() {
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
    }
    
    func showSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = true
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.searchBar.sizeToFit()
        searchController.searchBar.returnKeyType = UIReturnKeyType.search
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
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
                                                title: "Delete") { [weak self] _, _, completion in
                    // TODO: Model -> 해당 indexPath delete
                    var snapshot = self?.dataSource.snapshot()
                    snapshot?.deleteItems([item])
                    guard let snapShot = snapshot else { return }
                    self?.dataSource.apply(snapShot, animatingDifferences: false)
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
    
    // MARK: Actions
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        tabBarController?.tabBar.isHidden = editing
        issueListToolBar.isHidden = !editing
        
        navigationItem.leftBarButtonItem = editing ? selectAllLeftBarButton : filterLeftBarButton
        if editing {
            navigationItem.rightBarButtonItem?.title = "Cancel"
            navigationItem.rightBarButtonItem?.style = .plain
        }
        
        if #available(iOS 14.0, *) {
            issueListCollectionView.isEditing = editing
            issueListCollectionView.allowsMultipleSelectionDuringEditing = editing
        } else {
            issueListCollectionView.allowsMultipleSelection = editing
        }
        
        issueListCollectionView
            .indexPathsForVisibleItems
            .map { issueListCollectionView.cellForItem(at: $0) }
            .compactMap { $0 as? IssueListCollectionViewCell }
            .forEach { $0.isInEditingMode = editing }
    }
    
    @IBAction func closeSelectedIssueTouched(_ sender: UIBarButtonItem) {
        var snapshot = dataSource.snapshot()
        let selectedItems = issueListCollectionView
            .indexPathsForSelectedItems?
            .compactMap { dataSource.itemIdentifier(for: $0) }
        guard let deleteItems = selectedItems else {
            return
        }
        snapshot.deleteItems(deleteItems)
        dataSource.apply(snapshot, animatingDifferences: false)
        // TODO: 선택 이슈 닫기 -> 닫은 이슈 Model Update & Server Post
        // selectedItems
        //    .map { issueListCollectionView.cellForItem(at: $0) }
        //    .compactMap { $0 as? IssueListCollectionViewCell }
        //    .publisher
        //    .assign(to: &)
    }
    
    @objc private func filterTouched(_ sender: Any) {
        performSegue(withIdentifier: "IssueListFilterSegue", sender: nil)
    }
    
    @objc private func selectAllTouched(_ sender: Any) {
        // TODO: issue ViewModel List 가지고 있는 객체에서 -> forEach -> isSelect true
        // FIXME: SelectAll에서 클릭 안되는 문제
        isSelectedAll.toggle()
        //        if isSelectedAll {
        //            issueListCollectionView
        //                .indexPathsForVisibleItems
        //                .forEach { issueListCollectionView.selectItem(at: $0, animated: true, scrollPosition: .bottom) }
        //        } else {
        //            issueListCollectionView
        //                .indexPathsForVisibleItems
        //                .forEach { issueListCollectionView.deselectItem(at: $0, animated: true) }
        //        }
    }
}

// MARK: UISearchBarDelegate

extension IssueListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        performSearchQuery(with: searchText)
        self.searchText = searchText
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.navigationItem.searchController?.searchBar.text = searchText
    }
    
    func performSearchQuery(with filter: String?) {
        let issueListItems = issueListModelController
            .filteredBasedOnTitle(with: filter ?? "",
                                  model: displayedStore).sorted { $0.title < $1.title }
        var snapshot = NSDiffableDataSourceSnapshot<Section, IssueListViewModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(issueListItems)

        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

// MARK: UICollectionView DataSource

extension IssueListViewController {
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, IssueListViewModel>(
            collectionView: issueListCollectionView,
            cellProvider: {(collectionView, indexPath, item) -> UICollectionViewCell? in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IssueListCell",
                                                                    for: indexPath) as? IssueListCollectionViewCell
                else {
                    return UICollectionViewCell()
                }
                cell.configure(of: item)
                cell.systemLayoutSizeFitting(.init(width: self.view.bounds.width, height: 88))
                return cell
            })
    }
}

// MARK: UICollectionViewDelegate

extension IssueListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard isEditing else {
            let sender = displayedStore[indexPath.row].id
            guard let issueDetailViewController = self.storyboard?.instantiateViewController(
                        identifier: IssueDetailViewController.identifier,
                        creator: { coder -> IssueDetailViewController? in
                            return IssueDetailViewController(coder: coder, id: sender)
                        }) else { return }

            navigationController?.pushViewController(issueDetailViewController, animated: true)
            return
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        guard let cell = cell as? IssueListCollectionViewCell else { return }
        
        if isEditing != cell.isInEditingMode {
            cell.isInEditingMode = isEditing
        }
        if isSelectedAll {
            issueListCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
        }
        // TODO: deselect
    }
}
