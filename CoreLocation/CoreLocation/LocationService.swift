//
//  LocationService.swift
//  CoreLocation
//
//  Created by 허예은 on 2022/01/04.
//

import UIKit
import CoreLocation

public class LocationService: NSObject, CLLocationManagerDelegate {
    
    public static var sharedInstance = LocationService()
    
    let locationManager: CLLocationManager
    
    var locationDataArray: [CLLocation]
}


