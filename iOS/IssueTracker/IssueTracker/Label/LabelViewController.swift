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

final class LabelViewController: UIViewController {

    // MARK: Properties
    
    @IBOutlet weak var labelCollectionView: UICollectionView!
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, LabelViewModel>!
    private var interactor: LabelBusinessLogic!
    private var displayedLabel = [LabelViewModel]()

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

    // MARK: Actions

    @IBAction func makeLabelButtonTouched(_ sender: Any) {
        showAlert(type: .color) {
            self.interactor.fetchLabels()
        }
    }
}

// MARK: LabelDisplayLogic

extension LabelViewController: LabelDisplayLogic {
    func displayFetchedLabels(viewModel: [LabelViewModel]) {
        displayedLabel = viewModel
        var snapshot = NSDiffableDataSourceSnapshot<Section, LabelViewModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(displayedLabel)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

// MARK: UICollectionView DataSource

extension LabelViewController {
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, LabelViewModel>(
            collectionView: labelCollectionView,
            cellProvider: {(collectionView, indexPath, item) -> UICollectionViewCell? in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LabelCollectionViewCell", for: indexPath) as? LabelCollectionViewCell
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

extension LabelViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }

        guard let title = item.labelButton.titleLabel?.text,
              let colorLabel = item.labelButton.backgroundColor?.hexString else { return }

        showAlert(type: .color,
                  id: item.id,
                  title: title,
                  description: item.description,
                  date: "",
                  colorLabel: colorLabel) {
            self.interactor.fetchLabels()
        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension LabelViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: self.view.bounds.width - 12, height: 80)
    }
}
