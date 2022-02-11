//
//  ViewController.swift
//  SignificantLocation
//
//  Created by mac on 2022/02/10.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    let locationManager: CLLocationManager = CLLocationManager()
    
    @IBOutlet weak var contentLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.pausesLocationUpdatesAutomatically = false
        // Do any additional setup after loading the view.
    }
    
    private func startSignificantLocationChanges() {
        if !CLLocationManager.significantLocationChangeMonitoringAvailable() {
            return
        }
        
        locationManager.startMonitoringSignificantLocationChanges()
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,  didUpdateLocations locations: [CLLocation]) {
        let lastLocation = locations.last!
        contentLabel.text = "\(lastLocation)"
       // Do something with the location.
    }
}

