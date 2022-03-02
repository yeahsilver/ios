//
//  ViewController.swift
//  DiffableCollectionView
//
//  Created by 허예은 on 2022/03/02.
//

import UIKit

class ViewController: UIViewController {
    // MARK: Properties
    private var contents = ["Apple", "Banana", "Camera", "Dog", "Eat", "Feat", "Goose"]
    private var dataSrouce: UICollectionViewDiffableDataSource<Section, String>!
    private var isFiltering: Bool {
        let searchController = navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
        
        return isActive && isSearchBarHasText
    }
    
    // MARK: Components
    private lazy var searchController: UISearchController = { createSearchController() }()
    private lazy var collectionView: UICollectionView = { createCollectionView() }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        initDataSource()
        performQuery(with: nil)
        // Do any additional setup after loading the view.
    }
    
    private func initDataSource() {
        collectionView.register(UICollectionView.self, forCellWithReuseIdentifier: "cell")
        dataSrouce = UICollectionViewDiffableDataSource<Section, String>(collectionView: self.collectionView, cellProvider: { [weak self] collectionView, indexPath, value in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            return cell
        })
        
        collectionView.dataSource = dataSrouce
    }
}

// MARK: UI Configuration
extension ViewController {
    private func createSearchController() -> UISearchController {
        let controller = UISearchController()
        return controller
    }
    
    private func createCollectionView() -> UICollectionView {
        let collectionView = UICollectionView()
        return collectionView
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection in
            
            let contentSize = layoutEnvironment.container.effectiveContentSize
            let columns = contentSize.width > 800 ? 3 : 2
            let spacing = CGFloat(10)
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(32)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
            group.interItemSpacing = .fixed(spacing)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = spacing
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            
            return section
        }
        return layout
    }
    
    private func style() {
        collectionView.collectionViewLayout = createCollectionViewLayout()
        
        navigationItem.searchController = searchController
        navigationItem.searchController?.searchResultsUpdater = self
        navigationItem.title = "Search"
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func layout() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
}

// MARK: Actions
extension ViewController {
    private func performQuery(with filter: String?) {
        let filtered = contents.filter { $0.hasPrefix(filter ?? "")}
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.main])
        snapshot.appendItems(filtered)
        dataSrouce.apply(snapshot, animatingDifferences: true)
    }
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text
        self.performQuery(with: text)
    }
}

// MARK: Enum
extension ViewController {
    enum Section: CaseIterable {
        case main
    }
}


class MyCollectionViewCell: UICollectionViewCell {
    private lazy var contentLabel: UILabel = { createContentLabel() }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createContentLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.frame = contentView.frame
        contentView.addSubview(label)
        return label
    }
    
    private func layout() {
        contentView.backgroundColor = .lightGray
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.black.cgColor
    }
    
    func setLabel(text: String) {
        contentLabel.text = text
    }
}
