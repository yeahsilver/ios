//
//  ViewController.swift
//  ConstraintPractice
//
//  Created by 허예은 on 2021/10/17.
//

import UIKit

class ViewController: UIViewController {
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("This is Button", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .darkGray
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        button.translatesAutoresizingMaskIntoConstraints = false
       
        return button
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "This is Label"
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(button)
    
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 200).isActive = true
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        view.addSubview(label)
        label.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 30).isActive = true
        label.leftAnchor.constraint(equalTo: button.leftAnchor, constant: 40).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        
    }
    

}

