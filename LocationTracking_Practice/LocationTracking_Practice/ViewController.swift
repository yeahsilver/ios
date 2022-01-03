//
//  ViewController.swift
//  LocationTracking_Practice
//
//  Created by 허예은 on 2021/12/30.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController {
    private lazy var statusLabel: UILabel = { createStatusLabel() }()
    private lazy var mapView: MKMapView = { createMapView() }()
    
    let locationSerivces = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLocationService()
        layout()
    }
    
    // Location Service 설정
    private func initLocationService() {
        locationSerivces.delegate = self
        locationSerivces.allowsBackgroundLocationUpdates = true
        locationSerivces.showsBackgroundLocationIndicator = true
        locationSerivces.distanceFilter = 100
        locationSerivces.desiredAccuracy = kCLLocationAccuracyBest
        
        guard CLLocationManager.locationServicesEnabled() else {
            return
        }
        
        // 앱 장소 항상 트래킹
        locationSerivces.requestAlwaysAuthorization()
        
        mapView.delegate = self
        mapView.showsUserLocation = true
    }
}

// MARK: Style
extension ViewController {
    private func createStatusLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24)
        label.numberOfLines = 0
        label.textAlignment = .center
        view.addSubview(label)
        
        return label
    }
    
    private func createMapView() -> MKMapView {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        
        return mapView
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            statusLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            mapView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mapView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mapView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor),
            mapView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor)
        ])
    }
}

// MARK: Functions
extension ViewController {
    func promptForAuthorization() {
        let alert = UIAlertController(title: "Location access is needed to get your current location", message: "Please allow location access", preferredStyle: .alert)
        let settingAction = UIAlertAction(title: "Settings", style: .default) { _ in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { [weak self] _ in
            self?.locationServicesNeededState()
        }
        
        alert.addAction(settingAction)
        alert.addAction(cancelAction)
        
        alert.preferredAction = settingAction
        
        present(alert, animated: true, completion: nil)
    }
    
    func locationServicesNeededState() {
        self.statusLabel.text = "Access to location services is needed."
    }
    
    func locationServicesRestrictedState() {
        self.statusLabel.text = "This app is restriced from using the location services."
    }
    
    func getCurrentTime() -> String {
        let now = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatter.string(from: now as Date)
    }
}


extension ViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        
        switch status {
            case .notDetermined:
                print("notDetermined")
                locationServicesNeededState()
            
            case .restricted:
                print("restricted")
                locationServicesRestrictedState()
            
            case .denied:
                print("denied")
                promptForAuthorization()
            
            case .authorizedAlways:
                print("authroizedAlways")
                locationSerivces.startUpdatingLocation()
            
            case .authorizedWhenInUse:
                print("authorizedWhenInUse")
            
            @unknown default:
                print("unknown")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for location in locations {
            print("\(getCurrentTime()): \(location.coordinate.latitude), \(location.coordinate.longitude)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let alert = UIAlertController(title: "에러", message: "GPS 신호가 존재하는 장소로 이동해주세요", preferredStyle: .alert)
        let confirmButton = UIAlertAction(title: "Confirm", style: .default, handler: nil)
        
        alert.addAction(confirmButton)
        
        present(alert, animated: true, completion: nil)
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "myAnnotation") as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myAnnotation")
        } else {
            annotationView?.annotation = annotation
        }
        if let annotation = annotation as? MKPinAnnotationColor {
            annotationView?.pinTintColor = .red
        }
        
        return annotationView
    }
}
