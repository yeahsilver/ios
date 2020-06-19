//
//  ViewController.swift
//  MyAlbum
//
//  Created by 허예은 on 2020/06/19.
//  Copyright © 2020 허예은. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func hello(_ sender: Any) {
        let alert = UIAlertController(title: "Hello", message:"My First App!!", preferredStyle: .alert) // alert view에 띄워질 메시지 생성
        let action = UIAlertAction(title:"OK", style: .default, handler:nil) // alert view에서 okay를 눌렀을 경우 현재는 handler가 nil이기에 아무액션도 취하지 않음.
        alert.addAction(action) // action 추가
        present(alert, animated: true, completion: nil) // view를 띄움.
    }
    
    @IBAction func welcome(_ sender: Any) {
        let alert = UIAlertController(title: "Welcome", message: "Welcome to my first app!!!", preferredStyle: .alert)
        let action = UIAlertAction(title :"OK", style: .default, handler:nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

// 오타가 발생했을 경우
// use of unresolved identifier 창이 뜸. 의미를 파악하고 고치기
// 자동완성 쓰기! --> 오타 감소

// 대소문자를 구분하는 swift! 대소문자 주의하기.!

// 중괄호 무시하는 경우 주의!

// thread 오류가 뜨는 경우
// component가 잘 연결되어있는지 확인하기
