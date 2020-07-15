//
//  TextViewController.swift
//  test_pageViewController
//
//  Created by 허예은 on 2020/07/15.
//  Copyright © 2020 허예은. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {

    let myText: String
    
    private let myTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.font = .systemFont(ofSize: 24)
        textView.textColor = .black
        return textView
    }()
    
    init(with text: String){
        self.myText = text
        myTextView.text = self.myText
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(self.myTextView)
    }
    
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        myTextView.frame = view.bounds
    }
}
