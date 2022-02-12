//
//  LocationService.swift
//  LocationTest
//
//  Created by mac on 2022/02/12.
//

import Foundation
import CoreLocation
import NotificationCenter

class LocationService: NSObject {
    static let shared = LocationService()
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    private override init() {
        locationManager = CLLocationManager()
        
        super.init()
        
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
    }
    
    var locationManager: CLLocationManager
}

extension LocationService {
    func notification(_ title: String = "Wolley 테스트", body: String) {
        let notificationCenter = UNUserNotificationCenter.current()
        
        notificationCenter.getNotificationSettings() { settings in
            if settings.alertSetting == .enabled {
                let content = UNMutableNotificationContent()
                content.title = title
                content.body = body
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                let request = UNNotificationRequest(identifier: "Test=\(UUID().uuidString ?? "")", content: content, trigger: trigger)
                
                notificationCenter.add(request) { error in
                    if error != nil {
                        
                    } else {
                        
                    }
                }
            }
        }
    }
}

extension LocationService {
    func startMonitoringLocation() {
        guard let latitude = locationManager.location?.coordinate.latitude,
              let longitude = locationManager.location?.coordinate.longitude else { return }
        
        let location  = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let region = CLCircularRegion(center: location, radius: 1.0, identifier: "location")
        region.notifyOnEntry = false
        region.notifyOnExit = true
        
        locationManager.startMonitoring(for: region)
        locationManager.startUpdatingLocation()
    }
    
    func stopMonitoringLocation() {
        let monitoredRegions = locationManager.monitoredRegions
    
        for region in monitoredRegions {
            locationManager.stopMonitoring(for: region)
        }
    }
    
    func getCurrentTime() -> String {
        let now = NSDate()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        return dateFormatter.string(from: now as Date)
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = locationManager.authorizationStatus
        
        switch status {
        case .notDetermined:
            print("not determined")
            locationManager.requestAlwaysAuthorization()
        case .restricted:
            print("restricted")
            break
        case .denied:
            print("denined")
            break
        case .authorizedAlways:
            print("authroized always")
            locationManager.requestAlwaysAuthorization()
        case .authorizedWhenInUse:
            print("authorized when in use")
            locationManager.requestAlwaysAuthorization()
        @unknown default:
            print("unknown")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        print("didStartMonitoringFor \(region)")
        #if DEBUG
        notification(body: "\(String(describing: getCurrentTime())): 새로운 장소 추적 시작 \(region)")
        #endif
    }
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        switch state {
            case .inside:
                print("inside")
                
            case .outside:
                print("outside")
                stopMonitoringLocation()
                startMonitoringLocation()
                
            case .unknown:
                break
        }
    }
}
