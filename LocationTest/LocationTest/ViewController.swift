//
//  ViewController.swift
//  LocationTest
//
//  Created by mac on 2022/02/04.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    let locationManager: CLLocationManager = {
        var locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if locationManager.responds(to: #selector(getter: CLLocationManager.allowsBackgroundLocationUpdates)) {
            locationManager.allowsBackgroundLocationUpdates = true
            locationManager.distanceFilter = 200
            
            startTracking()
        }
        
        func startTracking() {
            locationManager.startUpdatingLocation()
            locationManager.startMonitoringVisits()
            locationManager.startMonitoringSignificantLocationChanges()
        }
        
        return locationManager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        // Do any additional setup after loading the view.
    }
}

extension ViewController: CLLocationManagerDelegate {
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count > 0 {
            print("update location >>", locations.last)
            processLocation(locations.last!)
        }
    }
    
    func processLocation(_ location: CLLocation) {
        locationManager.stopUpdatingLocation()
        
        let monitoredRegions = locationManager.monitoredRegions
        
        for region in monitoredRegions {
            locationManager.stopMonitoring(for: region)
        }
        
        let lastRegion = CLCircularRegion(center: location.coordinate, radius: 200, identifier: UUID().uuidString)
        
        locationManager.startMonitoring(for: lastRegion)
    }
    
    func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {
        print("visit location >>", visit.coordinate)
        print(visit.departureDate, visit.arrivalDate)
    }
}


