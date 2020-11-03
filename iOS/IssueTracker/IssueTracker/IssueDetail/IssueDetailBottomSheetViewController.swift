//
//  IssueManagementViewController.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/03.
//

import UIKit

class IssueDetailBottomSheetViewController: UIViewController {

    @IBOutlet weak var handleArea: UIView!
    @IBOutlet weak var addCommentButton: UIButton!
    @IBOutlet weak var upButtom: UIButton!
    @IBOutlet weak var downButton: UIButton!
//    let fullView: CGFloat = 100
//    var partialView: CGFloat {
//        return UIScreen.main.bounds.height - (addCommentButton.frame.maxY + UIApplication.shared.statusBarFrame.height)
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//        prepareBackgroundView()
//
//        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(IssueManagementViewController.panGesture))
//        view.addGestureRecognizer(gesture)
//
//    }
//
//    @objc func panGesture(_ recognizer: UIPanGestureRecognizer) {
//
//        let translation = recognizer.translation(in: self.view)
//        let velocity = recognizer.velocity(in: self.view)
//        let y = self.view.frame.minY
//        if ( y + translation.y >= fullView) && (y + translation.y <= partialView ) {
//            self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
//            recognizer.setTranslation(CGPoint.zero, in: self.view)
//        }
//
//        if recognizer.state == .ended {
//            var duration =  velocity.y < 0 ? Double((y - fullView) / -velocity.y) : Double((partialView - y) / velocity.y )
//
//            duration = duration > 1.3 ? 1 : duration
//
//            UIView.animate(withDuration: duration, delay: 0.0, options: [.allowUserInteraction], animations: {
//                if  velocity.y >= 0 {
//                    self.view.frame = CGRect(x: 0, y: self.partialView, width: self.view.frame.width, height: self.view.frame.height)
//                } else {
//                    self.view.frame = CGRect(x: 0, y: self.fullView, width: self.view.frame.width, height: self.view.frame.height)
//                }
//
//            }, completion: nil)
//        }
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        UIView.animate(withDuration: 0.3) { [weak self] in
//            let frame = self?.view.frame
//            let yComponent = UIScreen.main.bounds.height - 200
//            self?.view.frame = CGRect(x: 0, y: yComponent, width: frame!.width, height: frame!.height)
//        }
//    }
//
//    func prepareBackgroundView() {
//        let blurEffect = UIBlurEffect.init(style: .light)
//        let visualEffect = UIVisualEffectView.init(effect: blurEffect)
//        let bluredView = UIVisualEffectView.init(effect: blurEffect)
//        bluredView.contentView.addSubview(visualEffect)
//
//        visualEffect.frame = UIScreen.main.bounds
//        bluredView.frame = UIScreen.main.bounds
//
//        view.insertSubview(bluredView, at: 0)
//    }
}
