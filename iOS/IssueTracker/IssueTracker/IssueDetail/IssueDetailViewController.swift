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
        addBottomSheetView()
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
                as? IssueManagementViewController else { return }

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
}

extension IssueDetailViewController: UICollectionViewDelegate {

}

extension IssueDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        return collectionView.dequeueReusableCell(withReuseIdentifier: "IssueDetailCell", for: indexPath)
    }
}
