//
//  IssueDetailViewController.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/02.
//

import UIKit

final class IssueDetailViewController: UIViewController {
    
    // MARK: Properties
    
    private var issueDetailBottomSheet: IssueDetailBottomSheetViewController!
    private var visualEffectView: UIVisualEffectView!
    private var cardVisible = false
    private var runningAnimations = [UIViewPropertyAnimator]()
    private var animationProgressWhenInterrupted: CGFloat = .zero
    private let cardHeight: CGFloat = 600
    private let cardHandleAreaHeight: CGFloat = 65
    
    var nextState: BottomSheetState {
        return cardVisible ? .collapsed : .expanded
    }
    
    // MARK: View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        // addBottomSheetView()
        configureBottomSheet()
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        tabBarController?.tabBar.isHidden = false
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

extension IssueDetailViewController: UICollectionViewDelegate {
    
}

extension IssueDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IssueDetailCell", for: indexPath)
        return cell
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
        view.addSubview(visualEffectView)
        
        // issueDetailBottomSheet = IssueDetailBottomSheetViewController(nibName: "BottomSheetTest", bundle: nil)
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
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                          action: #selector(self.bottomSheetTapped(recognzier:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self,
                                                          action: #selector(self.bottomSheetPanned(recognizer:)))
        
        issueDetailBottomSheet.handleArea.addGestureRecognizer(tapGestureRecognizer)
        issueDetailBottomSheet.handleArea.addGestureRecognizer(panGestureRecognizer)
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

// 옛날꺼 BottomSheet
extension IssueDetailViewController {
    func addBottomSheetView() {
        guard let storyboard = UIStoryboard.init(name: "IssueList", bundle: nil)
                .instantiateViewController(identifier: "IssueManagementViewController")
                as? IssueDetailBottomSheetViewController else { return }
        let bottomSheetVC = storyboard
        
        self.addChild(bottomSheetVC)
        self.view.addSubview(bottomSheetVC.view)
        bottomSheetVC.didMove(toParent: self)
        
        let height = view.frame.height
        let width  = view.frame.width
        bottomSheetVC.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
    }
}
