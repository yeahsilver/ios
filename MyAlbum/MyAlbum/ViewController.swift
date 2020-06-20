//
//  ViewController.swift
//  MyAlbum
//
//  Created by 허예은 on 2020/06/19.
//  Copyright © 2020 허예은. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue = 0
    @IBOutlet var priceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refresh()
    }

    @IBAction func welcome(_ sender: Any) {
        
        let message = "가격은 ₩\(currentValue)입니다."
        
        let alert = UIAlertController(title: "Welcome", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title :"OK", style: .default, handler:{action in self.refresh()}) // handler에 속성을 넣어줌. action을 취했을 때만 코드를 실행. == closure ({action: ~ }까지.)
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    func refresh(){
        let randomPrice = arc4random_uniform(10000) + 1
        currentValue = Int(randomPrice)
        priceLabel.text = "₩\(currentValue)"
    }
}

// 오타가 발생했을 경우
// use of unresolved identifier 창이 뜸. 의미를 파악하고 고치기
// 자동완성 쓰기! --> 오타 감소

// 대소문자를 구분하는 swift! 대소문자 주의하기.!

// 중괄호 무시하는 경우 주의!

// thread 오류가 뜨는 경우
// component가 잘 연결되어있는지 확인하기
