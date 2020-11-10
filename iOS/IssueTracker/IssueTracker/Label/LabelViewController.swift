//
//  LabelViewController.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/10.
//

import UIKit

protocol LabelDisplayLogic: class {
    func displayFetchedLabels(viewModel: [LabelViewModel])
}

class LabelViewController: UIViewController, LabelDisplayLogic {

    @IBOutlet weak var labelCollectionView: UICollectionView!
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, LabelViewModel>!

    private var interactor: LabelBusinessLogic!

    enum Section {
        case main
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor.fetchLabels()
    }

    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = LabelInteractor()
        let presenter = LabelPresenter()
        self.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }

    private var displayedLabel = [LabelViewModel]()

    func displayFetchedLabels(viewModel: [LabelViewModel]) {
        displayedLabel = viewModel
        var snapshot = NSDiffableDataSourceSnapshot<Section, LabelViewModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(displayedLabel)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension LabelViewController {
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, LabelViewModel>(
            collectionView: labelCollectionView,
            cellProvider: {(collectionView, indexPath, item) -> UICollectionViewCell? in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LabelCollectionViewCell",
                                                                    for: indexPath) as? LabelCollectionViewCell
                else {
                    return UICollectionViewCell()
                }
                cell.configure(viewModel: item)
//                cell.systemLayoutSizeFitting(.init(width: self.view.bounds.width, height: 88))
                return cell
            })
    }
}

extension LabelViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: self.view.bounds.width, height: 80)
    }
}
