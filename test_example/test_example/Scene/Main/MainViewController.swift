//
//  MainViewController.swift
//  test_example
//
//  Created by 허예은 on 2021/11/19.
//

import Combine
import UIKit

class MainViewController: UIViewController {
    private lazy var collectionView = { createCollectionView() }()
    
    private var viewModel: MainViewModelType
    private var lectures: Lectures?
    private var subscriptions = Set<AnyCancellable>()
    
    enum Section {
        case all
    }
    
    init(viewModel: MainViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension MainViewController {
    private func bind() {
        viewModel.listSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] response in
                self?.lectures = response
                
                Log.debug(self?.lectures?.pagination.count)
            }.store(in: &subscriptions)
    }
}
extension MainViewController {
    private func createCollectionView() -> UICollectionView {
        let collectionView = UICollectionView()
        collectionView.register(UICollectionView.self, forCellWithReuseIdentifier: "Cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        return collectionView
    }
    
//    private func collectionDataSource() -> UICollectionViewDiffableDataSource<Section, String> {
//        let cellID = "dataCell"
//
//        let dataSource = UICollectionViewDiffableDataSource<Section, String>(
//            collectionView: collectionView, cellProvider: {
//                collectionView, indexPath, data in
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
//
//             return cell
//            }
//        )
//        return dataSource
//    }
    
    private func style() {
        
    }
    
    private func layout() {
        let guide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: guide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: guide.trailingAnchor)
        ])
    }
}
