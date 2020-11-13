//
//  ViewControllerTest.swift
//  IssueTrackerTests
//
//  Created by ParkJaeHyun on 2020/11/13.
//

import XCTest
@testable import IssueTracker

class ViewControllerTest: XCTestCase {
    // MARK: - Subject under test

    var sut: IssueListViewController!
    var window: UIWindow!

    // MARK: - Test lifecycle

    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupListOrdersViewController()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    // MARK: - Test setup

    func setupListOrdersViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "IssueList", bundle: bundle)
        sut = storyboard.instantiateViewController(
            withIdentifier: "IssueListViewController"
        ) as? IssueListViewController
    }

    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    // MARK: - Test doubles

    class IssueListBusinessLogicSpy: IssueListBusinessLogic {

        var issues: IssueList = []

        // MARK: Method call expectations

        var fetchListsCalled = false

        // MARK: Spied methods
        func closeIssue(id: Int, state: Int, handler: @escaping () -> Void) {
            fetchListsCalled = true
        }

        func fetchIssues() {
            fetchListsCalled = true
        }

        func changeIssueState() {
            fetchListsCalled = true
        }

        func filtered(with filter: String, model: [IssueListViewModel]) {
            fetchListsCalled = true
        }
    }

    class DataSource: UICollectionViewDiffableDataSource<IssueListViewController.Section, IssueListViewModel> {

    }

    class CollectionViewDiffableDataSourceSpy: DataSource {
        // MARK: Method call expectations

        override init() {
            let layout = UICollectionViewFlowLayout()
            let collectionView = UICollectionView(frame: .init(), collectionViewLayout: layout)
            super.init(collectionView: collectionView) { (_, _, _) -> UICollectionViewCell? in
                return UICollectionViewCell()
            }
        }

        var applyCalled = false

        // MARK: Spied methods

        override func apply(_ snapshot: NSDiffableDataSourceSnapshot<IssueListViewController.Section, IssueListViewModel>, animatingDifferences: Bool = true, completion: (() -> Void)? = nil) {
            applyCalled = true
        }

    }

    // MARK: - Tests

    func test_Should_FetchLists_When_ViewDidAppear() {
        // Given
        let issueListBusinessLogicSpy = IssueListBusinessLogicSpy()
        sut.interactor = issueListBusinessLogicSpy

        // When
        loadView()
        sut.viewDidAppear(true)

        // Then
        XCTAssert(issueListBusinessLogicSpy.fetchListsCalled, "viewDidAppear가 되면 interactor가 실행되어야 합니다.")
    }

    func test_Should_DisplayFetched_Lists() {
        // Given
        let collectionViewDiffableDataSourceSpy = CollectionViewDiffableDataSourceSpy()
        sut.dataSource = collectionViewDiffableDataSourceSpy

        // When
        let viewModel = [IssueListViewModel(id: 1,
                                            title: "title",
                                            description: "설명",
                                            milestone: CustomButtonView(type: .label, text: "버튼", color: "#ffffff"),
                                            labels: [CustomButtonView(type: .label, text: "버튼1", color: "#ffffff"),
                                                     CustomButtonView(type: .label, text: "버튼2", color: "#ffffff")],
                                            isOpen: true)]
        sut.displayFetchedIssues(viewModel: viewModel)

        // Then
        XCTAssert(collectionViewDiffableDataSourceSpy.applyCalled,
                  "displayFetchedIssues메소드가 불리면 apply가 실행되어야 합니다.")
    }

    func test_NumberOfRows_In_Any_Section_Should_Eqaul_NumberOfOrders_To_Display() {
        // Given
        let testDisplayedLists = [IssueListViewModel(id: 1,
                                                     title: "title",
                                                     description: "설명",
                                                     milestone: CustomButtonView(type: .label,
                                                                                 text: "버튼",
                                                                                 color: "#ffffff"),
                                                     labels: [CustomButtonView(type: .label,
                                                                               text: "버튼1",
                                                                               color: "#ffffff"),
                                                              CustomButtonView(type: .label,
                                                                               text: "버튼2",
                                                                               color: "#ffffff")],
                                                     isOpen: true)]

        // When
        loadView()
        sut.displayedIssue = testDisplayedLists
        sut.performApply()
        let numberOfRows = sut.issueListCollectionView.numberOfItems(inSection: 0)

        // Then
        XCTAssertEqual(numberOfRows, testDisplayedLists.count, "CollectionView의 item 갯수가 같아야 합니다.")
    }

    func test_Should_Configure_CollectionView_Cell_To_DisplayList() {
        // Given
        let testDisplayedLists = [IssueListViewModel(id: 1,
                                                     title: "cellTest",
                                                     description: "설명",
                                                     milestone: CustomButtonView(type: .label,
                                                                                 text: "버튼",
                                                                                 color: "#ffffff"),
                                                     labels: [CustomButtonView(type: .label,
                                                                               text: "버튼1",
                                                                               color: "#ffffff"),
                                                              CustomButtonView(type: .label,
                                                                               text: "버튼2",
                                                                               color: "#ffffff")],
                                                     isOpen: true),
                                  IssueListViewModel(id: 2,
                                                     title: "test",
                                                     description: "설명2",
                                                     milestone: CustomButtonView(type: .label,
                                                                                 text: "버튼2",
                                                                                 color: "#ffffff"),
                                                     labels: [CustomButtonView(type: .label,
                                                                               text: "버튼3",
                                                                               color: "#ffffff"),
                                                              CustomButtonView(type: .label,
                                                                               text: "버튼4",
                                                                               color: "#ffffff")],
                                                     isOpen: true)]
        sut.displayedIssue = testDisplayedLists

        // When
        loadView()
        let indexPath = IndexPath(row: 0, section: 0)
        guard let cell = sut.dataSource.collectionView(
            sut.issueListCollectionView,
            cellForItemAt: indexPath
        ) as? IssueListCollectionViewCell else { return }

        // Then
        XCTAssertEqual(cell.titleLabel.text, "cellTest", "")
        XCTAssertEqual(cell.descriptionLabel.text, "설명", "")
    }

    func test_closeSelectedIssueTouched_User_Action() {
        //Given
        let testDisplayedLists = [IssueListViewModel(id: 1,
                                                     title: "cellTest",
                                                     description: "설명",
                                                     milestone: CustomButtonView(type: .label,
                                                                                 text: "버튼",
                                                                                 color: "#ffffff"),
                                                     labels: [CustomButtonView(type: .label,
                                                                               text: "버튼1",
                                                                               color: "#ffffff"),
                                                              CustomButtonView(type: .label,
                                                                               text: "버튼2",
                                                                               color: "#ffffff")],
                                                     isOpen: true),
                                  IssueListViewModel(id: 2,
                                                     title: "test",
                                                     description: "설명2",
                                                     milestone: CustomButtonView(type: .label,
                                                                                 text: "버튼2",
                                                                                 color: "#ffffff"),
                                                     labels: [CustomButtonView(type: .label,
                                                                               text: "버튼3",
                                                                               color: "#ffffff"),
                                                              CustomButtonView(type: .label,
                                                                               text: "버튼4",
                                                                               color: "#ffffff")],
                                                     isOpen: true)]

        //When
        loadView()
        sut.displayedIssue = testDisplayedLists
        sut.performApply()
        sut.issueListCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .bottom)
        sut.closeSelectedIssueTouched(UIBarButtonItem(title: "선택 이슈 닫기", style: .plain, target: nil, action: nil))

        //Then
        let number = sut.issueListCollectionView.numberOfItems(inSection: 0)
        XCTAssertEqual(number, 1, "2개에서 한개가 삭제되므로 1개 남아야 합니다.")
    }

    func test_selectAllTouched_User_Action() {
        //Given
        let testDisplayedLists = [IssueListViewModel(id: 1,
                                                     title: "cellTest",
                                                     description: "설명",
                                                     milestone: CustomButtonView(type: .label,
                                                                                 text: "버튼",
                                                                                 color: "#ffffff"),
                                                     labels: [CustomButtonView(type: .label,
                                                                               text: "버튼1",
                                                                               color: "#ffffff"),
                                                              CustomButtonView(type: .label,
                                                                               text: "버튼2",
                                                                               color: "#ffffff")],
                                                     isOpen: true),
                                  IssueListViewModel(id: 2,
                                                     title: "test",
                                                     description: "설명2",
                                                     milestone: CustomButtonView(type: .label,
                                                                                 text: "버튼2",
                                                                                 color: "#ffffff"),
                                                     labels: [CustomButtonView(type: .label,
                                                                               text: "버튼3",
                                                                               color: "#ffffff"),
                                                              CustomButtonView(type: .label,
                                                                               text: "버튼4",
                                                                               color: "#ffffff")],
                                                     isOpen: true)]

        //When
        loadView()
        sut.displayedIssue = testDisplayedLists
        sut.performApply()
        sut.selectAllTouched(2)

        //Then
        let number = sut.issueListCollectionView.indexPathsForSelectedItems?[0].count
        XCTAssertEqual(number, 2, "2개 아이템에서 selectAllTouched를 실행 시켰으니 2가 되어야한다.")
    }
}
