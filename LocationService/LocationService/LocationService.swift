//
//  LocationService.swift
//  LocationService
//
//  Created by mac on 2022/01/07.
//

import Foundation
import CoreLocation
import NotificationCenter

class LocationService: NSObject {
    static let shared = LocationService()
    
    private override init() {
        locationManager = CLLocationManager()
        
        super.init()
        
        locationManager.delegate = self
        
    }
    
    var locationManager: CLLocationManager
}

extension LocationService {
    func fireNotification(_ title: String = "Background Test", body: String) {
            let notificationCenter = UNUserNotificationCenter.current()
            
            notificationCenter.getNotificationSettings { (settings) in
                if settings.alertSetting == .enabled {
                    let content = UNMutableNotificationContent()
                    content.title = title
                    content.body = body
                    
                    let uuidString = UUID().uuidString
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                    let request = UNNotificationRequest(identifier: "Test-\(uuidString)", content: content, trigger: trigger)
                    notificationCenter.add(request, withCompletionHandler: { (error) in
                        if error != nil {
                            // Handle the error
                        }
                    })
                }
            }
        }
}

extension LocationService {
    func registLocation() {
        var locations = [
            CLLocationCoordinate2D(latitude: 37.4967867, longitude: 126.9978993),
            CLLocationCoordinate2D(latitude: 37.402187224511, longitude: 127.10304698035)
        ]
        
        var count = 0
        
        for location in locations {
            let region = CLCircularRegion(center: location, radius: 1.0, identifier: "\(count)")
            region.notifyOnEntry = true
            region.notifyOnExit = true
            locationManager.startMonitoring(for: region)
            print("region register: \(region)")
            count+=1
        }
        
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        
        locationManager.startUpdatingLocation()
    }
}
 
extension LocationService: CLLocationManagerDelegate {
    func requestAlwaysLocation() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        case .authorizedWhenInUse:
            locationManager.requestAlwaysAuthorization()
        case .authorizedAlways:
            registLocation()
        default:
            print("Location is not avaiable.")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        print("didStartMonitoringFor \(region)")
    }
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        switch state {
        case .inside:
            fireNotification(body: "\(region)에 들어왔습니다.")
        case .outside:
            fireNotification(body: "\(region)에서 나왔습니다.")
            
            
        case .unknown: break
            // do not something
        }
    }
}
