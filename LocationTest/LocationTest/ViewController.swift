//
//  ViewController.swift
//  LocationTest
//
//  Created by mac on 2022/02/12.
//

import UIKit

class ViewController: UIViewController {
    let userNotiCenter = UNUserNotificationCenter.current()
    let locationService = LocationService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestAuthNoti()
        
        // Do any additional setup after loading the view.
    }

    private func requestAuthNoti() {
        let notiAuthOptions = UNAuthorizationOptions(arrayLiteral: [.alert, .badge, .sound])
        userNotiCenter.requestAuthorization(options: notiAuthOptions) { _, error in
            if let error = error {
                print(#function, error)
            }
        }
    }
}

