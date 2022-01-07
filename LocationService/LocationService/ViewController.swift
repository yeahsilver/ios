//
//  ViewController.swift
//  LocationService
//
//  Created by mac on 2022/01/07.
//

import UIKit

class ViewController: UIViewController {
    
    let locationService = LocationService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationService.requestAlwaysLocation()
        // Do any additional setup after loading the view.
    }


}

