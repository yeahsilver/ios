//
//  ViewController.swift
//  DiffableTest
//
//  Created by 허예은 on 2022/03/01.
//

import UIKit

class ViewController: UIViewController {
    // MARK: Properties
    private var dataSource: UITableViewDiffableDataSource<Int, UUID>!
    private var snapshot = NSDiffableDataSourceSnapshot<Int, UUID>()
    private var colors: [UIColor] = [.red, .yellow, .orange, .blue, .gray]
    
    
    // MARK: Components
    private lazy var tableView: UITableView = { createTableView() }()
    private lazy var insertButton: UIButton = { createButton() }()
    private lazy var appendButton: UIButton = { createButton() }()
    private lazy var deleteButton: UIButton = { createButton() }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableViewDataSource()
        initSnapshot()
    
        style()
        layout()
    }
    
    private func initTableViewDataSource() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        
        dataSource = UITableViewDiffableDataSource<Int, UUID>(tableView: tableView, cellProvider: {
            [weak self] tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
            cell.backgroundColor = self?.colors[indexPath.row % (self?.colors.count)!]
            
            return cell
        })
        
        tableView.dataSource = dataSource
    }
    
    private func initSnapshot() {
        snapshot.appendSections([0])
        snapshot.appendItems([UUID(), UUID(), UUID()])
        dataSource.apply(snapshot)
    }
}

// MARK: UI Configuration
extension ViewController {
    private func createTableView() -> UITableView {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }
    
    private func createButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    private func style() {
        view.addSubview(tableView)
        view.addSubview(appendButton)
        view.addSubview(insertButton)
        view.addSubview(deleteButton)
        
        appendButton.setTitle("append", for: .normal)
        appendButton.setTitleColor(.systemBlue, for: .normal)
        appendButton.addTarget(self, action: #selector(appendButtonDidTap), for: .touchUpInside)
        
        insertButton.setTitle("insert", for: .normal)
        insertButton.setTitleColor(.systemBlue, for: .normal)
        insertButton.addTarget(self, action: #selector(insertButtonDidTap), for: .touchUpInside)
        
        deleteButton.setTitle("delete", for: .normal)
        deleteButton.setTitleColor(.systemBlue, for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteButtonDidTap), for: .touchUpInside)
    }
    
    private func layout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            appendButton.topAnchor.constraint(equalTo: safeArea.topAnchor),
            appendButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            appendButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            appendButton.bottomAnchor.constraint(equalTo: insertButton.topAnchor),
            appendButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            insertButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            insertButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            insertButton.bottomAnchor.constraint(equalTo: deleteButton.topAnchor),
            insertButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            deleteButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            insertButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}


// MARK: Actions
extension ViewController {
    @objc private func insertButtonDidTap() {
        var snapshot = dataSource.snapshot()
        
        if let first = snapshot.itemIdentifiers.first {
            snapshot.insertItems([UUID()], afterItem: first)
        }
        
        dataSource.apply(snapshot)
    }
    
    @objc private func appendButtonDidTap() {
        var snapshot = dataSource.snapshot()
        
        snapshot.appendItems([UUID()])
        dataSource.apply(snapshot)
    }
    
    @objc private func deleteButtonDidTap() {
        var snapshot = dataSource.snapshot()
        
        if let lastItem = snapshot.itemIdentifiers.last {
            snapshot.deleteItems([lastItem])
        }
        dataSource.apply(snapshot)
    }
}

