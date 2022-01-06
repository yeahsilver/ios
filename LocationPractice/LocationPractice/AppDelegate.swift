//
//  AppDelegate.swift
//  LocationPractice
//
//  Created by 허예은 on 2022/01/03.
//

import UIKit
import CoreLocation
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private let locationSerivces = CLLocationManager()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ViewController() // 특정 ViewController
        window?.makeKeyAndVisible()
        
        let notification = UNUserNotificationCenter.current()
        notification.requestAuthorization(options: [.alert, .badge, .sound]) { isSuccess, error in
            if isSuccess {
                print("사용자 승인")
            }
        }
        
        if let location = launchOptions?[.location] as? [AnyHashable: Any] {
            
        }
        
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
        
        UNUserNotificationCenter.current().getNotificationSettings() { settings in
            if settings.authorizationStatus == UNAuthorizationStatus.authorized {
                print("알람 허용")
                
                let content = UNMutableNotificationContent()
                content.badge = 1
                content.sound = UNNotificationSound.default
                content.title = "백그라운드 처리"
                content.body = "백그라운드가 시작되었습니다."
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                
                let request = UNNotificationRequest(identifier: "BackgroundNotification", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request)
            }
        }
        
        locationSerivces.startMonitoringSignificantLocationChanges()
    }
}
