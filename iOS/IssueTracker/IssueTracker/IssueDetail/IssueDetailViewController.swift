//
//  IssueDetailViewController.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/02.
//

import UIKit

class IssueDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
//        addBottomSheetView()
        setupCard()
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }

    func configureNavigationItem() {
        let editButtonItem = UIBarButtonItem(title: "Edit",
                                             style: .plain,
                                             target: nil,
                                             action: #selector(editButtonTouched))
        navigationItem.rightBarButtonItem = editButtonItem
    }

    func addBottomSheetView() {
        // 1- Init bottomSheetVC
        guard let storyboard = UIStoryboard.init(name: "IssueList",
                                                 bundle: nil)
                .instantiateViewController(identifier: "IssueManagementViewController")
                as? IssueDetailBottomSheetViewController else { return }

        let bottomSheetVC = storyboard

        // 2- Add bottomSheetVC as a child view
        self.addChild(bottomSheetVC)
        self.view.addSubview(bottomSheetVC.view)
        bottomSheetVC.didMove(toParent: self)

        // 3- Adjust bottomSheet frame and initial position.
        let height = view.frame.height
        let width  = view.frame.width
        bottomSheetVC.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
    }

    @objc func editButtonTouched() {

    }
    
    var issueDetailBottomSheet: IssueDetailBottomSheetViewController!
    var visualEffectView: UIVisualEffectView!
    
    let cardHeight: CGFloat = 600
    let cardHandleAreaHeight: CGFloat = 65
    
    var cardVisible = false
    var nextState:CardState {
        return cardVisible ? .collapsed : .expanded
    }
    
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted:CGFloat = 0
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

extension IssueDetailViewController {
    enum CardState {
            case expanded
            case collapsed
        }
        
        func setupCard() {
            visualEffectView = UIVisualEffectView()
            visualEffectView.frame = self.view.frame
            self.view.addSubview(visualEffectView)
            
//            issueDetailBottomSheet = IssueDetailBottomSheetViewController(nibName: "BottomSheetTest", bundle: nil)
            guard let viewController = UIStoryboard(name: "IssueList", bundle: nil)
                    .instantiateViewController(identifier: "IssueDetailBottomSheet")
                    as? IssueDetailBottomSheetViewController else { return }
            issueDetailBottomSheet = viewController
                
            self.addChild(issueDetailBottomSheet)
            self.view.addSubview(issueDetailBottomSheet.view)
            
            issueDetailBottomSheet.view.frame = CGRect(x: 0,
                                                       y: self.view.frame.height-cardHandleAreaHeight,
                                                       width: self.view.bounds.width,
                                                       height: cardHeight)
            
            issueDetailBottomSheet.view.clipsToBounds = true
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleCardTap(recognzier:)))
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handleCardPan(recognizer:)))
            
            issueDetailBottomSheet.handleArea.addGestureRecognizer(tapGestureRecognizer)
            issueDetailBottomSheet.handleArea.addGestureRecognizer(panGestureRecognizer)
            
            
        }

        @objc func handleCardTap(recognzier:UITapGestureRecognizer) {
            switch recognzier.state {
            case .ended:
                animateTransitionIfNeeded(state: nextState, duration: 0.9)
            default:
                break
            }
        }
        
        @objc func handleCardPan (recognizer:UIPanGestureRecognizer) {
            switch recognizer.state {
            case .began:
                startInteractiveTransition(state: nextState, duration: 0.9)
            case .changed:
                let translation = recognizer.translation(in: self.issueDetailBottomSheet.handleArea)
                var fractionComplete = translation.y / cardHeight
                fractionComplete = cardVisible ? fractionComplete : -fractionComplete
                updateInteractiveTransition(fractionCompleted: fractionComplete)
            case .ended:
                continueInteractiveTransition()
            default:
                break
            }
            
        }
        
        func animateTransitionIfNeeded (state:CardState, duration:TimeInterval) {
            if runningAnimations.isEmpty {
                let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                    switch state {
                    case .expanded:
                        self.issueDetailBottomSheet.view.frame.origin.y = self.view.frame.height - self.cardHeight
                    case .collapsed:
                        self.issueDetailBottomSheet.view.frame.origin.y = self.view.frame.height-self.cardHandleAreaHeight
                    }
                }
                
                frameAnimator.addCompletion { _ in
                    self.cardVisible = !self.cardVisible
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
        
        func startInteractiveTransition(state:CardState, duration:TimeInterval) {
            if runningAnimations.isEmpty {
                animateTransitionIfNeeded(state: state, duration: duration)
            }
            for animator in runningAnimations {
                animator.pauseAnimation()
                animationProgressWhenInterrupted = animator.fractionComplete
            }
        }
        
        func updateInteractiveTransition(fractionCompleted:CGFloat) {
            for animator in runningAnimations {
                animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
            }
        }
        
        func continueInteractiveTransition (){
            for animator in runningAnimations {
                animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
            }
        }
}
