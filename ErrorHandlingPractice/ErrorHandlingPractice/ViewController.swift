//
//  ViewController.swift
//  ErrorHandlingPractice
//
//  Created by mac on 2022/02/01.
//

import UIKit

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private func piechartBind() {
        viewModel.piechart
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                switch result {
                case .success(let data):
                    self?.dailyData = data
                    self?.summaryCollectionView.reloadData()
                case .requestErr:
                    self?.piechartErrorData()
                case .pathErr:
                    self?.piechartErrorData()
                case .serverErr:
                    self?.piechartErrorData()
                case .networkFail:
                    self?.piechartErrorData()
                }
            }, onError: { [weak self] result in
                self?.settingNetworkAlert()
                self?.piechartErrorData()
            }).disposed(by: disposeBag)
    }
}


class ViewModel {
    func getMap(date: String) {
        service.getMap(date: date)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                WolleyLog.debug("GET /map result >>", result)
                self?.map.onNext(result)
                
            }, onError: { [weak self] error in
                self?.map.onError(error)
                WolleyLog.debug("GET /map error >>", error)
                
            }).disposed(by: disposeBag)
    }
}

