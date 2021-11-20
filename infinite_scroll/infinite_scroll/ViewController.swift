//
//  ViewController.swift
//  infinite_scroll
//
//  Created by 허예은 on 2021/11/17.
//

import UIKit

class ViewController: UIViewController {
    private lazy var tableView = { createTableView() }()
    private lazy var footerView = { createFooterSpinnerView() }()
    
    private var data = [String]()
    private var apiCaller: APICallerType
    private var dataCount = 0
    
    init(apiCaller: APICallerType) {
        self.apiCaller = apiCaller
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bind()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension ViewController {
    private func bind() {
        apiCaller.fetchData(pagination: false, count: dataCount, completion: { [weak self] result in
            switch result {
            case .success(let data):
                self?.data.append(contentsOf: data)
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
                self?.dataCount += 1
                
            case .failure(_):
                break
            }
        })
    }
}
// MARK: - Configure UI
extension ViewController {
    private func createTableView() -> UITableView {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        return tableView
    }
    
    private func createFooterSpinnerView() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        footerView.backgroundColor = .red
          
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        
        footerView.addSubview(spinner)
        
        spinner.startAnimating()
        
        return footerView
    }
    
    private func style() {
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func layout() {
        let guide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: guide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor)
        ])
    }
}

// MARK: - Configure Actions
extension ViewController {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
         
        // defaultContentCOnfiguration: content view customization을 위해 지원되는 모든 프로퍼티 및 동작을 캡슐화
        var content = cell.defaultContentConfiguration()
        content.textProperties.alignment = .justified
        content.text = data[indexPath.row]
    
        cell.contentConfiguration = content
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > tableView.contentSize.height-100-scrollView.frame.size.height {
            // fetch more data
            print("fetch more data")
            
            guard !apiCaller.isPaginating else {
                // we are already fetching more data
                print("we are already fetching more data")
                return
            }
            
            self.tableView.tableFooterView = createFooterSpinnerView()
            
            apiCaller.fetchData(pagination: true, count: dataCount) { [weak self] result in
                DispatchQueue.main.async {
                    self?.tableView.tableFooterView = nil
                }
                
                switch result {
                case .success(let moreData):
                    self?.data.append(contentsOf: moreData)
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                    
                    self?.dataCount+=1;
                    
                case .failure(_):
                    break
                }
            }
        }
    }
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UIScrollViewDelegate {
    
}
