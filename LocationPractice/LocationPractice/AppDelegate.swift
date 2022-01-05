//
//  AppDelegate.swift
//  LocationPractice
//
//  Created by 허예은 on 2022/01/03.
//

import UIKit
import CoreLocation

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let locationSerivces = CLLocationManager()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ViewController() // 특정 ViewController
        window?.makeKeyAndVisible()
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("application Did Enter Background")
        startMySignificantLocationChanges()
    }
    
    private func startMySignificantLocationChanges() {
        if !CLLocationManager.significantLocationChangeMonitoringAvailable() {
            print("significant location change monitoring is not availiable")
            return
        }
        
        print("available")
        locationSerivces.startMonitoringSignificantLocationChanges()
    }
}

