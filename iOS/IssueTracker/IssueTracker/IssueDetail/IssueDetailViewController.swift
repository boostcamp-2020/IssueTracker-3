//
//  IssueDetailViewController.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/02.
//

import UIKit
import Combine

protocol IssueDetailDisplayLogic: class {
    func displayFetchedComments(viewModel: [IssueDetailViewModel])
}

protocol IssueDetailBottomSheetDelegate: class {
    func addCommentViewShouldAppear()
    func issueDetailViewShouldScrollUp()
    func issueDetailViewShouldScrollDown()
    func issueDetailViewShouldCloseIssue()
}

final class IssueDetailViewController: UIViewController, IssueDetailDisplayLogic {
    static let identifier = "IssueDetailViewController"
    
    // MARK: Properties
    
    @IBOutlet weak var issueDetailCollectionView: UICollectionView!
    
    private var interactor: IssueDetailBusinessLogic!
    private weak var issueDetailBottomSheet: IssueDetailBottomSheetViewController!
    private var visualEffectView: UIVisualEffectView!
    private var runningAnimations = [UIViewPropertyAnimator]()
    private var animationProgressWhenInterrupted: CGFloat = .zero
    private var bottomSheetVisible = false
    private var bottomSheetHeight: CGFloat = .zero
    private let bottomSheetHandleAreaHeight: CGFloat = 100

    private var publisher: AnyCancellable!

    // MARK: Enums

    enum Section: Hashable {
        case main
    }

    private var dataSource: UICollectionViewDiffableDataSource<Section, IssueDetailViewModel>!

    var nextState: BottomSheetState {
        return bottomSheetVisible ? .collapsed : .expanded
    }
    
    private let id: Int!
    private let firstComment: IssueListViewModel!

    init?(coder: NSCoder, id: Int, firstComment: IssueListViewModel) {
        self.id = id
        self.firstComment = firstComment
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        self.id = nil
        self.firstComment = nil
        super.init(coder: coder)
    }

    // MARK: View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        configureDataSource()
        configureBottomSheet()
        configureNotification()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor.fetchComments(id: id)
        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }

    private func configureNotification() {
        publisher = NotificationCenter.default
            .publisher(for: Notification.Name("createIssueClosed"))
            .sink { [weak self] _ in
//                guard let id = issueNubmer.userInfo?["issueNumber"] as? Int else { return }
//                self?.interactor.fetchComments(id: id)
                self?.navigationController?.popViewController(animated: true)
            }
    }
    
    private func setup() {
        let interactor = IssueDetailInteractor()
        let presenter = IssueDetailPresenter()
        self.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = self
        
        _ = [id].publisher.assign(to: \.issueID, on: issueDetailBottomSheet)
    }

    private var displayedStore = [IssueDetailViewModel]()

    func displayFetchedComments(viewModel: [IssueDetailViewModel]) {
        displayedStore = viewModel
        var snapshot = NSDiffableDataSourceSnapshot<Section, IssueDetailViewModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(displayedStore)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func configureNavigationItem() {
        let editButtonItem = UIBarButtonItem(title: "Edit",
                                             style: .plain,
                                             target: self,
                                             action: #selector(editButtonTouched))
        navigationItem.rightBarButtonItem = editButtonItem
    }
    
    @objc func editButtonTouched() {
        let storyBoard = UIStoryboard(name: "IssueList", bundle: nil)
        guard let viewController = storyBoard
                .instantiateViewController(identifier: "CreateIssueViewController")
                as? CreateIssueViewController else { return }
        viewController.isEdit = true
        viewController.issueNumber = id
        viewController.titleText = firstComment.title
        viewController.body = firstComment.description
        present(viewController, animated: true)
    }
}

// MARK: UICollectionView DataSource

extension IssueDetailViewController {
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, IssueDetailViewModel>(
            collectionView: issueDetailCollectionView,
            cellProvider: {(collectionView, indexPath, item) -> UICollectionViewCell? in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IssueDetailCell",
                                                                    for: indexPath) as? IssueDetailCollectionViewCell
                else {
                    return UICollectionViewCell()
                }
                cell.configure(of: item)
                let img = "https://user-images.githubusercontent.com/5876149/97951341-39d26600-1ddd-11eb-94e7-9102b90bda8b.jpg"
                self.interactor.loadAuthorImage(imageURL: img) { data in
                    DispatchQueue.main.async {
                        cell.profileImage.image = UIImage(data: data)
                    }
                }
                return cell
            })

        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else {
                return UICollectionReusableView()
            }
            
            guard let headerView = collectionView
                    .dequeueReusableSupplementaryView(ofKind: kind,
                                                      withReuseIdentifier: IssueDetailCollectionReusableView.identifier,
                                                      for: indexPath)
                    as? IssueDetailCollectionReusableView else { return  UICollectionReusableView() }
            
            headerView.configure(item: self.firstComment)
            
            return headerView
        }
    }
}

extension IssueDetailViewController: IssueDetailBottomSheetDelegate {
    enum BottomSheetState {
        case expanded
        case collapsed
    }

    private func configureBottomSheet() {
        bottomSheetHeight = (view.frame.height * 2) / 3
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = view.frame
        visualEffectView.isUserInteractionEnabled = false
        view.addSubview(visualEffectView)

        guard let viewController = UIStoryboard(name: "IssueList", bundle: nil)
                .instantiateViewController(identifier: "IssueDetailBottomSheet")
                as? IssueDetailBottomSheetViewController else { return }
        issueDetailBottomSheet = viewController
        issueDetailBottomSheet.delegate = self
        
        self.addChild(issueDetailBottomSheet)
        self.view.addSubview(issueDetailBottomSheet.view)
        
        issueDetailBottomSheet.view.frame = CGRect(x: .zero,
                                                   y: view.frame.height-bottomSheetHandleAreaHeight,
                                                   width: view.bounds.width,
                                                   height: bottomSheetHeight)
        issueDetailBottomSheet.view.clipsToBounds = true

        let panGestureRecognizer = UIPanGestureRecognizer(target: self,
                                                          action: #selector(self.bottomSheetPanned(recognizer:)))
        
        issueDetailBottomSheet.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    private func animateTransitionIfNeeded(state: BottomSheetState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.issueDetailBottomSheet.view.frame.origin.y =
                        self.view.frame.height - self.bottomSheetHeight
                case .collapsed:
                    self.issueDetailBottomSheet.view.frame.origin.y =
                        self.view.frame.height - self.bottomSheetHandleAreaHeight
                }
            }
            
            frameAnimator.addCompletion { _ in
                self.bottomSheetVisible = !(self.bottomSheetVisible)
                self.runningAnimations.removeAll()
            }
            
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
            
            let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
                switch state {
                case .expanded:
                    self.issueDetailBottomSheet.view.layer.cornerRadius = 12
                case .collapsed:
                    self.issueDetailBottomSheet.view.layer.cornerRadius = 0
                }
            }
            
            cornerRadiusAnimator.startAnimation()
            runningAnimations.append(cornerRadiusAnimator)
            
            let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.visualEffectView.effect = UIBlurEffect(style: .dark)
                    self.visualEffectView.alpha = 0.3
                case .collapsed:
                    self.visualEffectView.effect = nil
                }
            }
            
            blurAnimator.startAnimation()
            runningAnimations.append(blurAnimator)
        }
    }
    
    private func startInteractiveTransition(state: BottomSheetState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }
    
    private func updateInteractiveTransition(fractionCompleted: CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        }
    }
    
    private func continueInteractiveTransition() {
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
    
    @objc func bottomSheetTapped(recognzier: UITapGestureRecognizer) {
        switch recognzier.state {
        case .ended:
            animateTransitionIfNeeded(state: nextState, duration: 0.9)
        default:
            break
        }
    }

    @objc func bottomSheetPanned(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            startInteractiveTransition(state: nextState, duration: 0.9)
        case .changed:
            let translation = recognizer.translation(in: issueDetailBottomSheet.handleArea)
            var fractionComplete = translation.y / bottomSheetHeight
            fractionComplete = bottomSheetVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            continueInteractiveTransition()
        default:
            break
        }
    }
    
    func addCommentViewShouldAppear() {
        guard runningAnimations.isEmpty else { return }
        if bottomSheetVisible {
            animateTransitionIfNeeded(state: .collapsed, duration: 0.9)
            bottomSheetVisible.toggle()
        }
        let storyboard = UIStoryboard(name: "IssueList", bundle: nil)
        let commentNavigationController = storyboard.instantiateViewController(
            identifier: "CommentNavigationController")
        guard let commentViewController = commentNavigationController.children.first
                as? IssueCommentViewController else {
            return
        }
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alertController.setValue(commentNavigationController, forKey: "contentViewController")
        
        let height = NSLayoutConstraint(item: alertController.view!,
                                        attribute: NSLayoutConstraint.Attribute.height,
                                        relatedBy: NSLayoutConstraint.Relation.equal,
                                        toItem: nil,
                                        attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                        multiplier: 1,
                                        constant: 350)
        let width = NSLayoutConstraint(item: alertController.view!,
                                       attribute: NSLayoutConstraint.Attribute.width,
                                       relatedBy: NSLayoutConstraint.Relation.equal,
                                       toItem: nil,
                                       attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                       multiplier: 1,
                                       constant: 300)
        alertController.view.addConstraint(height)
        alertController.view.addConstraint(width)
        
        _ = [id].publisher.assign(to: \.issueID, on: commentViewController)
        commentViewController.completionHandler = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        self.present(alertController, animated: true)
    }
    
    func issueDetailViewShouldScrollUp() {
        guard var minIndexPath = issueDetailCollectionView.indexPathsForVisibleItems.min() else {
            return
        }
        if minIndexPath.item > 0 {
            minIndexPath.item -= 1
        }
        issueDetailCollectionView.scrollToItem(at: minIndexPath, at: .top, animated: true)
    }
    
    func issueDetailViewShouldScrollDown() {
        guard var maxIndexPath = issueDetailCollectionView.indexPathsForVisibleItems.max() else {
            return
        }
        if maxIndexPath.item < issueDetailCollectionView.numberOfItems(inSection: 0) {
            maxIndexPath.item += 1
        }
        issueDetailCollectionView.scrollToItem(at: maxIndexPath, at: .bottom, animated: true)
    }
    
    func issueDetailViewShouldCloseIssue() {
        let networkService = NetworkService()
        networkService.request(apiConfiguration: IssueListEndPoint.changeState(id, 0)) { [weak self] result in
            switch result {
            case .failure(let error):
                debugPrint(error)
                return
            case .success(_: ):
                DispatchQueue.main.async {
                    self?.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
}
