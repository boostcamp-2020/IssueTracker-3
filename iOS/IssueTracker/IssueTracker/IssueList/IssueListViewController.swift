//
//  IssueListViewController.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/02.
//

import UIKit

class IssueListViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension IssueListViewController: UICollectionViewDelegate {
    
}

extension IssueListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //      guard let cell = collectionView.dequeueReusableCell(
        //              withReuseIdentifier: "IssueListCell", for: indexPath) else {
        //        return UICollectionViewCell()
        //      }
        return collectionView.dequeueReusableCell(withReuseIdentifier: "IssueListCell", for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
      return collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                             withReuseIdentifier: "HeaderCollectionReusableView",
                                                             for: indexPath)
    }
}


