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


}

