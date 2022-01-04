//
//  ViewController.swift
//  LocationPractice
//
//  Created by 허예은 on 2022/01/03.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    private lazy var statusLabel: UILabel = { createStatusLabel() }()
    private let locationSerivces = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLocationService()
        layout()
    }
    
    // Location Service 설정
    private func initLocationService() {
        locationSerivces.delegate = self
        locationSerivces.allowsBackgroundLocationUpdates = true
        locationSerivces.showsBackgroundLocationIndicator = false //location manager가 위치 정보 수신을 일시 중지 할 수 있는지 여부를 결정
        
        guard CLLocationManager.locationServicesEnabled() else {
            return
        }
        
        // 앱 장소 항상 트래킹 (앱의 사용 중과 관계겂이 위치 서비스에 대한 사용자의 권한 요청)
        locationSerivces.requestAlwaysAuthorization()
        locationSerivces.pausesLocationUpdatesAutomatically = false
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
    
    private func layout() {
        NSLayoutConstraint.activate([
            statusLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}

// MARK: Functions
extension ViewController {
    private func promptForAuthorization() {
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
    
    private func locationServicesNeededState() {
        self.statusLabel.text = "Access to location services is needed."
    }
    
    private func locationServicesRestrictedState() {
        self.statusLabel.text = "This app is restriced from using the location services."
    }
    
    private func getCurrentTime() -> String {
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
        if let location = locations.last {
            
            statusLabel.text = "\(getCurrentTime())\n \(location.coordinate.latitude), \(location.coordinate.longitude)"
            
            if UIApplication.shared.applicationState != .active {
                print("App is in background mode at location. \(location.coordinate.latitude), \(location.coordinate.longitude)")
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let alert = UIAlertController(title: "에러", message: "GPS 신호가 존재하는 장소로 이동해주세요", preferredStyle: .alert)
        let confirmButton = UIAlertAction(title: "Confirm", style: .default, handler: nil)
        
        alert.addAction(confirmButton)
         
        present(alert, animated: true, completion: nil)
    }
}
