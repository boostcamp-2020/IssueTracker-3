//
//  MilestoneViewController.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/11.
//

import UIKit

protocol MilestoneDisplayLogic: class {
    func displayFetchedMilestones(viewModel: [MilestoneViewModel])
}

final class MilestoneViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet private weak var milestoneCollectionView: UICollectionView!
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, MilestoneViewModel>!
    private var interactor: MilestoneBusinessLogic!
    private var displayedMilestones = [MilestoneViewModel]()
    
    // MARK: Enums
    
    enum Section {
        case main
    }

    // MARK: View Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor.fetchMilestones()
    }
    
    // MARK: Setup
    
    private func setup() {
        let interactor = MilestoneInteractor()
        let presenter = MilestonePresenter()
        self.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = self
    }
    
    // MARK: Actions

    @IBAction func makeMilestoneTouched(_ sender: UIBarButtonItem) {
        showAlert(type: .date) {
            self.interactor.fetchMilestones()
        }
    }
}

// MARK: MilestoneDisplayLogic

extension MilestoneViewController: MilestoneDisplayLogic {
    func displayFetchedMilestones(viewModel: [MilestoneViewModel]) {
        displayedMilestones = viewModel
        var snapshot = NSDiffableDataSourceSnapshot<Section, MilestoneViewModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(displayedMilestones)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

// MARK: UICollectionView DataSource

extension MilestoneViewController {
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, MilestoneViewModel>(
            collectionView: milestoneCollectionView,
            cellProvider: {(collectionView, indexPath, item) -> UICollectionViewCell? in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MilestoneCollectionViewCell",
                                                                    for: indexPath) as? MilestoneCollectionViewCell
                else {
                    return UICollectionViewCell()
                }
                cell.configure(viewModel: item)

                cell.contentView.layer.cornerRadius = 10
                cell.contentView.clipsToBounds = true

                return cell
            })
    }
}

// MARK: UICollectionViewDelegate

extension MilestoneViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }

        guard let title = item.milestoneButton.titleLabel?.text else { return }

        showAlert(type: .date,
                  id: item.id,
                  title: title,
                  description: item.description,
                  date: item.dueDate,
                  colorLabel: "") {
            self.interactor.fetchMilestones()
        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension MilestoneViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: self.view.bounds.width - 12, height: 88)
    }
}
