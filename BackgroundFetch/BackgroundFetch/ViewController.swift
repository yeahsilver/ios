//
//  ViewController.swift
//  BackgroundFetch
//
//  Created by mac on 2022/02/08.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    private func updateTime() {
        let currentTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        
        timeLabel.text = formatter.string(from: currentTime)
    }

}

