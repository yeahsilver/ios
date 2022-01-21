//
//  ViewController.swift
//  GeofencingPractice
//
//  Created by 허예은 on 2022/01/20.
//

import MapKit
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let mockLocationService = MockLocationService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mockLocationService.stopMonitoringLocation()
        // Do any additional setup after loading the view.
    }
}

