//
//  IssueDetailViewController.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/02.
//

import UIKit

protocol IssueDetailDisplayLogic: class {
    func displayFetchedComments(viewModel: [IssueDetailViewModel])
}

final class IssueDetailViewController: UIViewController, IssueDetailDisplayLogic {
    static let identifier = "IssueDetailViewController"
    // MARK: Properties
    
    @IBOutlet weak var issueDetailCollectionView: UICollectionView!
    private weak var issueDetailBottomSheet: IssueDetailBottomSheetViewController!
    private var visualEffectView: UIVisualEffectView!
    private var cardVisible = false
    private var runningAnimations = [UIViewPropertyAnimator]()
    private var animationProgressWhenInterrupted: CGFloat = .zero
    private let cardHeight: CGFloat = 600
    private let cardHandleAreaHeight: CGFloat = 65

    private var interactor: IssueDetailBusinessLogic!

    // MARK: Enums

    enum Section: Hashable {
        case main
    }

    private var dataSource: UICollectionViewDiffableDataSource<Section, IssueDetailViewModel>!

    var nextState: BottomSheetState {
        return cardVisible ? .collapsed : .expanded
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
        // addBottomSheetView()
        configureDataSource()

        configureBottomSheet()
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

    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = IssueDetailInteractor()
        let presenter = IssueDetailPresenter()
        self.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }

    private var displayedStore = [IssueDetailViewModel]()

    func displayFetchedComments(viewModel: [IssueDetailViewModel]) {
        displayedStore = viewModel
        var snapshot = NSDiffableDataSourceSnapshot<Section, IssueDetailViewModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(displayedStore)

        dataSource.apply(snapshot, animatingDifferences: false)
    }

    // MARK: Configure View
    
    private func configureNavigationItem() {
        let editButtonItem = UIBarButtonItem(title: "Edit",
                                             style: .plain,
                                             target: nil,
                                             action: #selector(editButtonTouched))
        navigationItem.rightBarButtonItem = editButtonItem
    }
    
    @objc func editButtonTouched() {

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
                // cell.systemLayoutSizeFitting(.init(width: self.view.bounds.width, height: 88))
                return cell
            })

        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else {
                return UICollectionReusableView()
            }

            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: IssueDetailCollectionReusableView.identifier, for: indexPath)
                    as? IssueDetailCollectionReusableView else { return  UICollectionReusableView() }

            headerView.configure(item: self.firstComment)

            return headerView
        }
    }
}

// BottomSheet 수정 ver
extension IssueDetailViewController {
    enum BottomSheetState {
        case expanded
        case collapsed
    }

    private func configureBottomSheet() {
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = view.frame
        visualEffectView.isUserInteractionEnabled = false
        view.addSubview(visualEffectView)

        guard let viewController = UIStoryboard(name: "IssueList", bundle: nil)
                .instantiateViewController(identifier: "IssueDetailBottomSheet")
                as? IssueDetailBottomSheetViewController else { return }
        issueDetailBottomSheet = viewController
        
        self.addChild(issueDetailBottomSheet)
        self.view.addSubview(issueDetailBottomSheet.view)
        
        issueDetailBottomSheet.view.frame = CGRect(x: .zero,
                                                   y: view.frame.height-cardHandleAreaHeight,
                                                   width: view.bounds.width,
                                                   height: cardHeight)
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
                    self.issueDetailBottomSheet.view.frame.origin.y = self.view.frame.height - self.cardHeight
                case .collapsed:
                    self.issueDetailBottomSheet.view.frame.origin.y = self.view.frame.height - self.cardHandleAreaHeight
                }
            }
            
            frameAnimator.addCompletion { _ in
                self.cardVisible = !(self.cardVisible)
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
    
    // MARK: Actions
    
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
            var fractionComplete = translation.y / cardHeight
            fractionComplete = cardVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            continueInteractiveTransition()
        default:
            break
        }
    }
}
